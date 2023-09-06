import { defineStore } from "pinia";
import { useStorage } from "@vueuse/core";

// SuperTokens/Ultri Auth support
import Session from "supertokens-web-js/recipe/session";
import {
  createCode,
  consumeCode
} from "supertokens-web-js/recipe/passwordless";
// import auth from 'src/i18n/en-US/auth';

export const useAuthStore = defineStore("auth", {
  state: () => ({
    targetUrl: useStorage("targetUrl", null),
    memberEmail: useStorage("memberEmail", null),
    memberUid: useStorage("memberUid", null),
    signInRequired: useStorage("signInRequired", false),
    signInRequiredMsg: useStorage("signInRequiredMsg", null),
    createdAt: useStorage("createdAt", null),
    isNewMember: false
  }),
  getters: {
    isSignedIn(state) {
      if (state.memberUid && state.memberUid.length > 0) {
        return true;
      }
      return false;
    },
    member(state) {
      return {
        id: state.memberUid,
        email: state.memberEmail,
        createdAt: state.createdAt
      };
    }
  },
  actions: {
    notNewMember() {
      this.isNewMember = false;
    },
    $reset() {
      this.targetUrl = null;
      this.memberEmail = null;
      this.memberUid = null;
      (this.signInRequired = false),
        (this.signInRequiredMsg = null),
        (this.createdAt = null),
        (this.isNewMember = false);
    },
    setTargetUrl(url) {
      this.targetUrl = url;
    },
    setSignInRequired(bool) {
      this.signInRequired = bool;
    },
    setSignInRequiredMsg(msg) {
      console.log(msg);
      this.signInRequiredMsg = msg;
      this.signInRequired = true;
    },
    setMember(id, email, createdAt) {
      console.log();
      this.memberUid = id;
      this.memberEmail = email;
      this.createdAt = createdAt;
    },
    async sendEmailLogin(email) {
      try {
        console.log("SENDING Login Email: ", email);
        const response = await createCode({
          email
        });
        console.log("RESPONSE", response);
      } catch (err) {
        console.log("ERROR", err);
        if (err.isSuperTokensGeneralError === true) {
          // this may be a custom error message sent from the API by you,
          // or if the input email / phone number is not valid.
          window.alert(err.message);
        } else {
          window.alert("Oops! Something went wrong.");
        }
      }
    },
    async sendPhoneLogin(phone) {
      try {
        console.log("PHONE", phone);
        const response = await createCode({
          phoneNumber: phone
        });
        console.log("RESPONSE", response);
      } catch (err) {
        console.log("ERROR", err);
        if (err.isSuperTokensGeneralError === true) {
          // this may be a custom error message sent from the API by you,
          // or if the input email / phone number is not valid.
          window.alert(err.message);
        } else {
          window.alert("Oops! Something went wrong.");
        }
      }
    },
    async handleOTP(otp) {
      try {
        const response = await consumeCode({
          userInputCode: otp
        });

        if (response.status === "OK") {
          console.log("AUTHUSER", response.user);
          const createdAt = new Date(response.user.timeJoined).toISOString();
          this.setMember(response.user.id, response.user.email, createdAt);

          // Load Accounts

          if (response.createdNewUser) {
            this.isNewMember = true;
            console.log("NEW MEMBER", this.isNewMember);
          } else {
            // user sign in success
          }

          if (this.targetUrl && this.targetUrl.length > 0) {
            this.router.push(this.targetUrl);
          }

          return { status: "OK" };
        } else if (response.status === "INCORRECT_USER_INPUT_CODE_ERROR") {
          return {
            status: "INCORRECT_USER_INPUT_CODE_ERROR",
            maximumCodeInputAttempts: response.maximumCodeInputAttempts,
            failedCodeInputAttemptCount: response.failedCodeInputAttemptCount
          };
        } else if (response.status === "EXPIRED_USER_INPUT_CODE_ERROR") {
          // it can come here if the entered OTP was correct, but has expired because
          // it was generated too long ago.
          return {
            status: "EXPIRED_USER_INPUT_CODE_ERROR"
          };
        } else {
          // this can happen if the user tried an incorrect OTP too many times.
          return {
            status: "LOGIN_FAILED_ERROR"
          };
        }
      } catch (err) {
        console.log("ERROR", err);
        if (err.isSuperTokensGeneralError === true) {
          // this may be a custom error message sent from the API by you.
          return {
            status: err.message
          };
        } else {
          return {
            status: "LOGIN_FAILED"
          };
        }
      }
    },
    async signOut(url = "/") {
      await Session.signOut();

      this.router.push(url);
      this.$reset();
    },
    validateEmail(email) {
      return /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))(\+[a-z0-9-]+)?@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,24}))$/.test(email);
    },
    validateCode(otp) {
      return /^[0-9]{6}$/.test(otp);
    }
  }
});
