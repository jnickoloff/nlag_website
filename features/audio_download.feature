Feature: Audio file download
  In order to help teach the Word
  As a member of the congregation
  I want to download sermons from the web

  Background:
    Given the password for the messages page is "foo"

  Scenario: The messages page requires authorization
    Given I am on the "Messages" page
    Then a password prompt should be displayed

  Scenario: An incorrect password doesn't grant you access
    Given I am on the "Messages" page
    And I enter the text "wrong password" in the "password" field
    When I click the "submit" button
    Then a password prompt should be displayed
    And I should see the text "Incorrect password"

  Scenario: A correct password lets you in
    Given I am on the "Messages" page
    And I enter the text "foo" in the "password" field
    When I click the "submit" button
    Then I should see the text "Sermons"

  Scenario: An authorized user should see a list of MP3's
    Given I am on the "Messages" page
    And I enter the text "foo" in the "password" field
    When I click the "submit" button
    Then a table should contain the following rows of words
      """
      4.30 2012 Mr. Foo Bar Que?
      2.25 2012 Blarg Baz Great Sermon
      """

  Scenario: The incorrect password prompt should not be initially shown
    Given I am on the "Messages" page
    Then I should not see the text "Incorrect"

