# QavaJS Test Automation Framework

QavaJS is a powerful test automation framework leveraging Cucumber.js for BDD testing with additional tooling to simplify test creation and maintenance.

## Documentation

For official documentation, visit:
https://qavajs.github.io/docs/intro

## Getting Started

### Installation

```bash
npm install
```

### Running Tests

```bash
npm test
```

Or run directly with:

```bash
npx qavajs run --config config.ts
```

## Project Structure

- [config.ts](./config.ts) - Main configuration file for the test framework
- [features/](./features/) - Feature files containing test scenarios in Gherkin syntax
- [memory/](./memory/) - Test data and constants used across test scenarios
- [page_object/](./page_object/) - Page objects representing UI elements and their interactions
- [step_definitions/](./step_definitions/) - Custom step definitions specific to the project
- [report/](./report/) - Generated test reports (HTML, XML)

### Graphical Representation

```
qavajs-fnz/
├── config.ts                    # Main configuration file
├── package.json                 # Project dependencies
├── tsconfig.json                # TypeScript configuration
├── features/                    # Feature files (Gherkin)
│   └── Wikipedia.feature        # Wikipedia search feature
├── memory/                      # Test data and constants
│   └── index.ts                 # Constants declaration
├── page_object/                 # UI element representations
│   ├── index.ts                 # Main page object entry point
│   ├── Wikipedia.ts             # Wikipedia main page elements
│   └── WikipediaArticle.ts      # Wikipedia article page elements
├── step_definition/             # Custom step implementations
│   ├── api_steps_definitions.md # API step definitions
│   └── step_definitions.md      # UI step definitions
└── report/                      # Test execution reports
    ├── report.html              # HTML report
    └── report.xml               # XML report for CI integration
```

## Page Object Model

QavaJS provides a flexible page object model that resolves plain-English selectors and returns elements or arrays of elements.

### Creating Page Objects

The entry point of the page object model is the class defined as the \`pageObject\` property in the config:

```typescript
import { locator } from '@qavajs/steps-playwright/po';

class App {
    SimpleLocator = locator('.single-element');
    TemplateLocator = locator.template(text => `.class:has-text("${text}")`);
    NativeLocator = locator.native(({ browser, context, page, argument }) => page.getByText('some text'));
    Component = locator('.container').as(SingleComponent);
}

class SingleComponent {
    ChildItem = locator('.child-item');
}

export default App;
```

### Usage in Feature Files

```gherkin
Feature: Page Object Demo

    Scenario: Interact with element
        When I click 'Simple Locator'
```

### Template Locators

For dynamically generating selectors based on data:

```typescript
const { locator } = require('@qavajs/steps-playwright/po');

class Component {
    Element = locator.template(index => `div:nth-child(${index})`);
}
```

Then in your feature file:

```gherkin
When I click 'Component > Element (2)'
```

### Working with Collections

Define your own way to get elements from collections using template locators:

```typescript
import { locator } from '@qavajs/steps-playwright/po';

class App {
    ElementByIndex = locator.template(index => `xpath=//div[${index}]`);
    ElementByInnerText = locator.template(text => `div:has-text("${text}")`);
}
```

Using in feature files:

```gherkin
When I click 'Element By Index (1)'
When I click 'Element By Inner Text (some text)'
```

### Native Framework Locators

Use driver-built capabilities by passing a handler with access to the current page:

```typescript
const { locator } = require('@qavajs/steps-playwright/po');

class Component {
    Element = locator.native(({ page }) => page.getByText(`some text`));
}
```

### Using Page Objects in Custom Steps

Access page objects in custom steps via built-in parameter types:

```typescript
const { When } = require('@cucumber/cucumber');

// playwright
When('click {playwrightLocator}', async function (locator) {
    await locator.click();
});

// wdio
When('click {wdioLocator}', async function (locator) {
    await locator().click();
});
```

Used in feature files:

```gherkin
When click 'Product > Add To Cart'
```

## Writing Tests

QavaJS test cases leverage the Gherkin language, providing predefined steps for actions and assertions.

### Example Test

```gherkin
Feature: Wikipedia
  
  Scenario: Search in wikipedia
    Given I open '$wikipedia' url
    When I type 'JavaScript' to 'Search Input'
    And I click 'Search Button'
    And I expect text of 'Title' equals 'JavaScript'
```

In this scenario:
- \`Search Input\`, \`Search Button\`, and \`Title\` are aliases for corresponding page objects
- \`$wikipedia\` is an alias for a constant URL

### Page Objects Setup

Define page objects in the \`page_object\` folder:

```typescript
// page_object/index.ts
import { locator } from '@qavajs/steps-playwright/po';

export class App {
    SearchInput = locator('#searchInput');
    SearchButton = locator('button[type=submit]');
    Title = locator('#firstHeading');
}
```

### Constants Setup

Declare constants in the \`memory\` folder:

```typescript
// memory/index.ts
export class Constants {
    wikipedia = 'https://www.wikipedia.org/';
}
```

## Element Resolvers

QavaJS uses a powerful element resolution system that can find elements using intuitive, human-readable selectors.

### Default Resolver

The framework includes a sophisticated `defaultResolver` that supports multiple location strategies based on pattern matching:

#### Basic Patterns

- `text:Text` - finds elements by visible text content
- `label:Label` - finds form controls by associated label
- `role:button` - finds elements by ARIA role
- `placeholder:Search` - finds input elements by placeholder text
- `testid:myId` - finds elements by test ID attribute
- `title:Title` - finds elements by title attribute
- `alt:Image` - finds image elements by alt text
- `css:.selector` - finds elements using CSS selectors
- `xpath://xpath` - finds elements using XPath expressions

#### Combined Patterns

The resolver also supports more complex targeting using the format `{element} with {attribute}:{value}`:

- `link with text:Catalog` - finds a link with specific text
- `button with text:Submit` - finds a button with specific text
- `input with placeholder:Search` - finds an input with a specific placeholder
- `element with testid:myId` - finds an element with a specific test ID

#### Supported Element Types

- `link`: For targeting links/anchors
- `button`: For targeting button elements
- `checkbox`: For targeting checkbox inputs
- `input`: For targeting input fields
- `element`: Generic type for any element
- Any valid HTML tag name or Playwright role

#### Examples

```gherkin
# Using basic patterns
When I click 'text:Wikipedia Label'
When I click 'role:button'
When I click 'css:.search-button'

# Using combined patterns
When I click 'link with text:Catalog'
When I click 'button with text:Submit'
When I click 'input with placeholder:Search'
```

This powerful resolver allows you to write more readable test scenarios while maintaining precision in element targeting. The resolver automatically handles the appropriate Playwright locator strategy based on the pattern used.
