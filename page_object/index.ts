import { locator } from '@qavajs/steps-playwright/po';
import { Locator } from '@playwright/test';
import { Wikipedia } from './Wikipedia';
import { WikipediaArticle } from './WikipediaArticle';
import { WikipediaFooter } from './WikipediaFooter';

export class App {
  Wikipedia = locator('.search-container').as(Wikipedia);
  WikipediaArticle = locator('#content').as(WikipediaArticle);
  WikipediaFooter = locator('body').as(WikipediaFooter);

  Todos = locator('.todo-list li');
  TodoInput = locator('.new-todo');
  ClearCompleted = locator('.clear-completed');
  TodoCounter = locator('.todo-count');
  ActiveFilter = locator('a[href*=active]');
  CompletedFilter = locator('a[href*=completed]');


  /**
  * Advanced element resolver that supports multiple location strategies based on pattern matching.
  * 
  * @method defaultResolver
  * @param {Object} params - The parameters object
  * @param {string} params.alias - The alias string to resolve to a locator
  * @returns {Function} A function that takes a parent locator and returns a new locator
  * 
  * @description
  * This resolver supports both basic and combined element location strategies:
  * 
  * Basic patterns:
  * - text:Text → finds elements by visible text content
  * - label:Label → finds form controls by associated label
  * - role:button → finds elements by ARIA role
  * - placeholder:Search → finds input elements by placeholder text
  * - testid:myId → finds elements by test ID attribute
  * - title:Title → finds elements by title attribute
  * - alt:Image → finds image elements by alt text
  * - css:.selector → finds elements using CSS selectors
  * - xpath://xpath → finds elements using XPath expressions
  * 
  * Combined patterns (enhanced targeting):
  * - {element} with {attribute}:{value} → first narrows by element type, then by attribute
  * 
  * Supported element types:
  * - link: For targeting links/anchors
  * - button: For targeting button elements
  * - checkbox: For targeting checkbox inputs
  * - input: For targeting input fields
  * - element: Generic type for any element
  * - Any valid HTML tag name or Playwright role
  * 
  * @example
  * // Basic patterns
  * I.click('text:Wikipedia Label');        // Find by text
  * I.click('role:button');                 // Find button by role  
  * I.click('label:Username');              // Find form control by label
  * I.click('placeholder:Search');          // Find input by placeholder
  * I.click('testid:search-button');        // Find by test ID
  * I.click('title:Help');                  // Find by title attribute
  * I.click('alt:Logo');                    // Find image by alt text
  * I.click('css:.search-button');          // Find using CSS selector
  * I.click('xpath://button[@id="submit"]'); // Find using XPath
  * 
  * // Combined patterns for more precise targeting
  * I.click('link with text:Catalog');      // Find link with specific text
  * I.click('button with text:Submit');     // Find button with specific text
  * I.click('input with placeholder:Search'); // Find input with placeholder
  * I.click('element with testid:myId');    // Find element with specific test ID
  */
  defaultResolver({ alias }: { alias: string }) {
    return ({ parent }: { parent: Locator }) => {
      // Handle combined element-with-attribute pattern
      if (alias.includes(' with ')) {
        return this.resolveCombinedPattern(alias, parent);
      }
      
      // Handle basic patterns
      return this.resolveBasicPattern(alias, parent);
    };
  }
  
  /**
   * Resolves basic locator patterns like text:, css:, etc.
   */
  private resolveBasicPattern(alias: string, parent: Locator): Locator {
    const patternHandlers: Record<string, (value: string, parent: Locator) => Locator> = {
      'text:': (value, p) => p.getByText(value),
      'label:': (value, p) => p.getByLabel(value),
      'role:': (value, p) => p.getByRole(value as any),
      'placeholder:': (value, p) => p.getByPlaceholder(value),
      'testid:': (value, p) => p.getByTestId(value),
      'title:': (value, p) => p.getByTitle(value),
      'alt:': (value, p) => p.getByAltText(value),
      'css:': (value, p) => p.locator(value),
      'xpath:': (value, p) => p.locator(value)
    };

    // Try matching each pattern prefix
    for (const [prefix, handler] of Object.entries(patternHandlers)) {
      if (alias.startsWith(prefix)) {
        return handler(alias.substring(prefix.length), parent);
      }
    }
    
    // Default case - find by text
    return parent.getByText(alias);
  }
  
  /**
   * Resolves combined patterns like "element with attribute:value"
   */
  private resolveCombinedPattern(alias: string, parent: Locator): Locator {
    const parts = alias.split(' with ');
    if (parts.length !== 2) return parent.getByText(alias); // Fallback
    
    const [elementType, attributePart] = parts;
    const elementLocator = this.getElementLocator(elementType.toLowerCase(), parent);
    
    return this.applyAttributeFilter(elementType.toLowerCase(), elementLocator, attributePart, parent);
  }
  
  /**
   * Gets a locator for the element type (button, link, etc.)
   */
  private getElementLocator(elementType: string, parent: Locator): Locator {
    const elementHandlers: Record<string, (p: Locator) => Locator> = {
      'link': p => p.getByRole('link'),
      'button': p => p.getByRole('button'),
      'checkbox': p => p.getByRole('checkbox'),
      'input': p => p.locator('input'),
      'element': p => p
    };
    
    // Use predefined handler if available
    if (elementHandlers[elementType]) {
      return elementHandlers[elementType](parent);
    }
    
    // Try to use it as a role first
    try {
      return parent.getByRole(elementType as any);
    } catch {
      // Fall back to tag selector
      return parent.locator(elementType);
    }
  }
  
  /**
   * Applies the attribute filter to the element locator
   */
  private applyAttributeFilter(
    elementType: string, 
    elementLocator: Locator, 
    attributePart: string, 
    parent: Locator
  ): Locator {
    // Handle special cases
    if (attributePart.startsWith('text:')) {
      return elementLocator.getByText(attributePart.substring(5)).first();
    }
    
    if (attributePart.startsWith('label:')) {
      return parent.getByLabel(attributePart.substring(6)).filter({ has: elementLocator });
    }
    
    if (attributePart.startsWith('placeholder:')) {
      // Special case for inputs with placeholder
      if (elementType === 'input') {
        return parent.getByPlaceholder(attributePart.substring(11));
      }
      return elementLocator.filter({ has: parent.getByPlaceholder(attributePart.substring(11)) });
    }
    
    // Handle other attribute filters
    const attributeHandlers: Record<string, (value: string, elem: Locator, p: Locator) => Locator> = {
      'testid:': (value, elem, p) => elem.filter({ has: p.getByTestId(value) }),
      'title:': (value, elem, p) => elem.filter({ has: p.getByTitle(value) }),
      'alt:': (value, elem, p) => elem.filter({ has: p.getByAltText(value) })
    };
    
    for (const [prefix, handler] of Object.entries(attributeHandlers)) {
      if (attributePart.startsWith(prefix)) {
        return handler(attributePart.substring(prefix.length), elementLocator, parent);
      }
    }
    
    // If no recognized attribute prefix, assume it's text
    return elementLocator.filter({ hasText: attributePart });
  }
}