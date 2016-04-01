# Compose

> This project created as a technical challenge for an interview and completed relatively small amount of time. It's not recommended to use this in real life projects. I open sourced this to help others and get and idea of how something like this can be done.

Compose is a very simple email sending tool. It's written for a technical challenge for Frontend Engineer position. You can think it like a simple `Sent` box of an email client.

Here is the screencast, it may take some time to load and it may cut in half because of GitHub proxy. Better [Cmd+click here](http://recordit.co/penniVluhb) and open in a new tab.

![Compose Screencast](http://g.recordit.co/penniVluhb.gif)

### Technologies used

##### Backend
- NodeJS
- MongoLab
- Mongoose
- Express
- MailgunJS
- Nodemailer

##### Frontend
- CoffeeScript
- Grunt
- Bower
- Karma
- Stylus
- jQuery
- Handlebars
- Jasmine

The challenge was expecting me to implement an email sending service with a failover mechanism. If one of the services goes down it should immediately switch to another service.


### Setting up and running project on local

This projects depends `NodeJS`, `npm`, `grunt` and `bower`. I assume you already have them on your own machine. Remember that you will need Mongo and mailgun credentials to send and recieve emails.

- bower install
- npm install
- grunt client
- grunt server
- Open http://localhost:8888 on your browser


### Testing

I implemented Karma Test Runner with Jasmine and PhantomJS and added a few tests which you can see in `test_AppController.coffee`. To run tests you need to run `grunt karma`. It has its own file watcher so tests will run on background when you change a code.


### How did I implement it?

##### Backend

- App uses an implementation of Express server. In `routes.coffee` it adds pre-defined routes to Express Router. `*` will serve the `index.html`. For mail API `get` and `post` request are handled and wired to `MailModel`.

- App uses a free sandbox MongoDB instance from MongoLab and uses `Mongoose` to make it easy to working with Mongo. In `compose.coffee` a MongoDB connection is established. In `MailModel.coffee` a Mongoose schema is created and it's ready to handle Mongo operations.

- There are two different mail services to send mails which are `MailgunService` and `NodeMailerService`. Both of them is an implementation of `AbstractMailService` to provide the same public API.

- There is a `MailSender` implementation. Basically you write your services and register them to `MailSender` in priority then you use `MailSender` to send mails. It will use registered services and failover between them.

- When a mail is composed, `MailSender` will send it then `MailModel` will save it to MongoDB so then we can fetch and list composed mails in UI after refreshing the page.


##### Front End

- There is an `AppController` which will create `Router` and `AppView`. `AppController` is responsible to handle app state and it listens route changes to update views by telling to `AppView` which is responsible from drawing UI widgets and binding required events.

- All views are extending from a `BaseView` which provides some useful methods like `render`, `attach` and `detach`. For example, you can say a view class to render into an element by adding a `renderTo` option to your view class.

- All classes are extending from `EventEmitter` to be all event driven.

- A few words view management, `BaseView` expects `template` and `renderTo` options to work with. `template` is basically a `Handlebars` compiled function which will return a string markup. `BaseView` converts string markup into a DOM element using jQuery and append/prepend it to render target which is the `renderTo` option. Also we can use `attach` to add the `template` element into any other element and `detach` to remove it from DOM.

- Third party scripts are bundled in a file named `compose.third_party.min.js` and app scripts are bundled into a file named `compose.min.js`. There are several Grunt tasks in `build` folder which will transpile `CoffeeScript`'s to `JavaScript` and minify and concat them using `UglifyJS`.

- Stylus files are transpiled into CSS with Grunt Stylus task and all of them will be placed in a file named `compose.min.css`.

- App will only download `compose.third_party.min.js`, `compose.min.js` and `compose.min.css`.

- A footnote here, `Browserify` and `WebPack` would more easy to manage the dependencies and bundle them so I can get rid of the file arrays on `uglify.coffee` task.
