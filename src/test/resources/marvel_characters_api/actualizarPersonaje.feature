@REQ_HU-Geraldson001 @HU-Geraldson001 @marvel_characters_api @marvel_characters_api @Agente2 @E2 @iniciativa_marvel
Feature: HU-Geraldson001 Actualizar personaje (microservicio para gestión de personajes)

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

  @id:1 @actualizarPersonaje @exitoso200
  Scenario: T-API-HU-Geraldson001-CA01-Actualizar personaje exitosamente 200 - karate
    * def createData = read('classpath:data/marvel_characters_api/create_character_request.json')
    * def unique = java.util.UUID.randomUUID() + ''
    * set createData.name = 'Test Personaje ' + unique
    And request createData
    When method POST
    Then status 201
    * def personajeId = response.id
    Given path personajeId
    * def responseData = response
    * set responseData.name = 'Updated Test Personaje ' + unique
    And request responseData
    When method PUT
    Then status 200
    # And match response.id == personajeId
    # And match response.name == updateData.name

  @id:2 @actualizarPersonaje @noEncontrado404
  Scenario: T-API-HU-Geraldson001-CA02-Actualizar personaje no existente 404 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/update_character_request.json')
    Given path '999999'
    And request jsonData
    When method PUT
    Then status 404
    # And match response.error == 'Character not found'
    # And match response.status == 404
