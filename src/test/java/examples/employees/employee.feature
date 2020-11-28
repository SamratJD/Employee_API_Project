@employees
Feature: As a QA I want to validate the below functionalities of Employees API:
  		i) Create an employee data
  		ii) Call the Get Employee Data API
  		iii) Delete the Employee Data

  Background: 
    * url 'http://dummy.restapiexample.com/api/v1/'
    * configure retry = { count: 10, interval: 5000 }

  Scenario Outline: Validate status code and response for Create, Update and Delete Employee operations
    Given path '/create'
    And def requestBody =
      """
      {
      		"name":"<name>",
      		"salary":"<salary>",
      		"age":"<age>"
      }
      """
    And request requestBody
    When method post
    Then status <status>
    And match response ==
      """
      {
       "status": "success",
       "data": {
           "name": "<name>",
           "salary": "<salary>",
           "age": "<age>",
           "id": "#number"
        },
        "message": "Successfully! Record has been added."
      }
      """
    And def employeeId = response.data.id
    # Calling retrieve employee to validate the new record
    And def retrieveURL = 'http://dummy.restapiexample.com/api/v1/employee/' + employeeId
    And url retrieveURL
    And retry until responseStatus == 200
    When method get
    Then status <status>
    #And match response ==
    #"""
    #{
    #"status": "success",
    #"data": {
    #	"id": '#notnull',
    #	"employee_name": "<name>",
    #	"employee_salary": "<salary>",
    #	"employee_age": "<age>",
    #	"profile_image": '#notnull'
    #}
    #}
    #"""
    # Calling delete employee to delete the new record
    And def deleteURL = 'http://dummy.restapiexample.com/api/v1/delete/' + employeeId
    And url deleteURL
    And retry until responseStatus == 200
    When method get
    Then status <status>
    And match response ==
      """
      {
        "status": "success",
        "message": "successfully! deleted Records"
      }
      """

    Examples: 
      | name                  | salary | age | status |
      | Employee_Test_2811_01 |  80000 |  30 |    200 |
      | Employee_Test_2811_02 |  60000 |  28 |    200 |
