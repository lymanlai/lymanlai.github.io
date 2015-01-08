# [E2E Testing](https://docs.angularjs.org/guide/e2e-testing)

## Using Protractor
Protractor is a Node.js program, and runs end-to-end tests that are also written in JavaScript and run with node. Protractor uses [WebDriver](https://code.google.com/p/selenium/wiki/GettingStarted) to control browsers and simulate user actions.

For more information on Protractor, view [getting started](http://angular.github.io/protractor/#/getting-started) or the [api docs](http://angular.github.io/protractor/#/api).

Protractor uses Jasmine for its test syntax.

```
describe('TODO list', function() {
  it('should filter results', function() {

    // Find the element with ng-model="user" and type "jacksparrow" into it
    element(by.model('user')).sendKeys('jacksparrow');

    // Find the first (and only) button on the page and click it
    element(by.css(':button')).click();

    // Verify that there are 10 tasks
    expect(element.all(by.repeater('task in tasks')).count()).toEqual(10);

    // Enter 'groceries' into the element with ng-model="filterText"
    element(by.model('filterText')).sendKeys('groceries');

    // Verify that now there is only one item in the task list
    expect(element.all(by.repeater('task in tasks')).count()).toEqual(1);
  });
});
```

E2E testing works by testing full areas of the application by running a test through its entire stack of operations against a special HTTP server from the start to the end (hence end to end).