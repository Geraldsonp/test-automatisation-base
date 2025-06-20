@REQ_HU-Geraldson001 @HU-Geraldson001 @marvel_characters_api @marvel_characters_api @Agente2 @E2 @iniciativa_marvel
Feature: HU-Geraldson001 Eliminar personaje (microservicio para gestión de personajes)

  Background:
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/gaperez/api/characters'
    * def generarHeaders =
      """
      function() {
        return {
          "Content-Type": "application/json"
        };
      }
      """
    * def headers = generarHeaders()
    * headers headers

  @id:1 @eliminarPersonaje @exitoso204
  Scenario: T-API-HU-Geraldson001-CA01-Eliminar personaje exitosamente 204 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/create_character_request.json')
    * def unique = java.util.UUID.randomUUID() + ''
    * set jsonData.name = 'Test Personaje ' + unique
    And request jsonData
    When method POST
    Then status 201
    * def personajeId = response.id
    Given path personajeId
    When method DELETE
    Then status 204
    # And match response == null

  @id:2 @eliminarPersonaje @noEncontrado404
  Scenario: T-API-HU-Geraldson001-CA02-Eliminar personaje no existente 404 - karate
    Given path '999999'
    When method DELETE
    Then status 404
    # And match response.error == 'Character not found'
    # And match response.status == 404
