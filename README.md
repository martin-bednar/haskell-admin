# Haskell Admin

_Remote Management Suite for Haskell Applications_

## Basic information

Haskell Admin allows you to easily manage a running Haskell application from a different machine. It consists of
- __server side__ written in Haskell, that can be easily added to your existing application,
- __client side__ written in JavaScript, that provides a user-friendly GUI (see screenshots).

Both sides can run on the same machine, or separately.

## Usage

To integrate Haskell Admin into an existing Haskell application, you need to:

1. Set up the server side of Haskell Admin to run with your application
2. Set up the client side
3. Connect the client to the server

### Server-side setup

You'll need `haskell-admin` as a dependency in your application's `.cabal` file or `package.yaml`.

Then, you can use the `admin` function to set up the Haskell Admin server. Please refer to the [demo application](/server/haskell-admin-demo-app) for a complete example of the server side setup.

### Client setup

You can use the client locally or on a server - it's a JavaScript single page application (SPA).

To run locally:

```bash
cd client
npm install
npm run build
npm run start
```

### Connecting to the server

After starting both the server and the client, you can visit the client GUI at [localhost:5000](localhost:5000).

You'll be prompted to input details to connect to the Haskell Admin server.

If you are running `haskell-admin-demo-app` on your local machine, use the following data:

![Input data for the demo app](/media/screenshot-default-connection.png)


Then, the client app will connect and you'll see the main screen:

![Main screen - Application health](/media/screenshot2.png)

## Development

### Running the client

```bash
cd client
npm install
npm run dev
```

### Running the server (demo app)

```bash
cd server
stack run haskell-admin-demo-app-exe
```

## Testing

Use Stack to run the server-side tests:
```bash
stack test
```

Client-side test suite is'nt implemented yet.
## Screenshots

### Connection Screen

![Connection screen](/media/screenshot1.png)

### Main Screen

![Main screen - Application health](/media/screenshot2.png)

![Main screen - Managed Functions](/media/screenshot3.png)