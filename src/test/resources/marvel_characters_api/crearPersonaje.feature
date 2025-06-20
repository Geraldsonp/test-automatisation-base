@REQ_HU-Geraldson001 @HU-Geraldson001 @marvel_characters_api @marvel_characters_api @Agente2 @E2 @iniciativa_marvel
Feature: HU-Geraldson001 Crear personaje (microservicio para gestión de personajes)

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

  @id:1 @crearPersonaje @exitoso201
  Scenario: T-API-HU-Geraldson001-CA01-Crear personaje exitosamente 201 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/create_character_request.json')
    * def unique = java.util.UUID.randomUUID() + ''
    * set jsonData.name = 'Test Personaje ' + unique
    And request jsonData
    When method POST
    Then status 201
    # And match response.id != null
    # And match response.name == jsonData.name

  @id:2 @crearPersonaje @nombreDuplicado400
  Scenario: T-API-HU-Geraldson001-CA02-Crear personaje con nombre duplicado 400 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/create_character_duplicate_request.json')
    And request jsonData
    When method POST
    Then status 400
    # And match response.error == 'Character name already exists'
    # And match response.status == 400

  @id:3 @crearPersonaje @camposRequeridos400
  Scenario: T-API-HU-Geraldson001-CA03-Crear personaje con campos requeridos vacíos 400 - karate
    * def jsonData = { "name": "", "alterego": "", "description": "", "powers": [] }
    And request jsonData
    When method POST
    Then status 400
    # And match response.name == 'Name is required'
    # And match response.description == 'Description is required'

