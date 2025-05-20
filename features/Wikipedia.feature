Feature: Desktop Web Feature

  # @wikipedia
  # Scenario Outline: Search in wikipedia (<term>)
  #   Given I open '$wikipediaUrl' url
  #   When I type '<term>' to 'Wikipedia > Search Input'
  #   And I click 'Wikipedia > Search Button'
  #   And I expect text of 'Wikipedia Article > Title' equals '<term>'
  #   And I expect text of 'Wikipedia Article > Title' not to contain 'Python'
  #   And I expect 'Wikipedia Article > Title' to be visible
  #   And I expect 'Wikipedia Article > Title' to be visible

  #   Examples:
  #     | term       |
  #     | JavaScript |
  #     | Java       |


  @newTest
  Scenario: Demo Test Using Default Resolver
     Given I open 'https://www.onliner.by/' url
     When I click 'link with text:Каталог'
     Then I expect current url to contain 'catalog.onliner.by'

     When I click 'link with text:Форум'
     Then I expect current url to contain 'forum.onliner.by'