## Workspace Technical Details

* Requires a recent Chrome browser.
* The files never leave your computer.
* Easily used in Git projects.
* No tech skills or install required.
* Data stored and cached at multiple levels.
  * Pinia stores as the data access interface
  * ES6 Maps for reactive data
  * File System Access API for BLOBs, JSON, Markdown, and other data.
  * IndexDB to store the directory and files for better performance and persisting them across reboots.

### Workspace Data Flow

```mermaid
sequenceDiagram
  Webapp-->>Store: A web or mobile app accesses the store
  Store-->>Map: Pinia stores reactive data in Maps
  Store-->>IndexDB: Core Maps cached in IndexDB
  IndexDB-->>Map: Core Maps gets hydrated after reboot
  Map-->>Store: The store returns Map data
  Store-->>Workspace: Pinia stores binaries, markdown, and JSON in Workspace directory
  Workspace-->>GitServer: Git is used to share the data
  GitServer-->>StaticHosting: Merges auto-deploy to Netlify
  GitServer-->>Workspace: Revisions are merged into workspace data
  Workspace-->>Store: The store reads/writes from disk using File System Access API (fsaApi)
  Store-->>Webapp: The app receives information through the store
```
