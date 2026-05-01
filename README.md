# The-Cat-App
App for https://developers.thecatapi.com/

Aplicación iOS para explorar razas de gatos y ver imágenes de éstos, utilizando la api https://developers.thecatapi.com/

## Características principales

1. Listado completo de razas de gatos
2. Galería de imágenes responsive (2 columnas)
3. Filtro por cantidad de imágenes (1-100)
4. Detalles completos: temperamento, origen, esperanza de vida, información general.
5. Compartir imágenes de la raza seleccionada.


## Instalación 

1. Clona el repositorio
2. Abre `CatGallery.xcodeproj` en Xcode
3. (Opcional) Obtén una API Key gratis en [TheCatAPI](https://thecatapi.com/signup)
4. (Opcional) Pega la API Key en `Services/CatAPIService.swift`
5. Compila y ejecuta (Cmd + R)

## Tecnologías

- **Swift 5**
- **UIKit** (programático, sin Storyboards)
- **Codable** para serialización
- **URLSession** + JSON para persistencia local

## Funcionalidades principales

### Pantalla principal
- Muestra todas las razas de la API en un UIPicker (wheel)
- UITextfield para ingresar un número entero entre 1 a 100, que limitará mostrar ese número de resultados.
- Pantalla de detalles de la raza seleccionada. 
- Compartir la imagen con aplicaciones disponibles para compartir, o guardar en el dispositivo.

### Video de muestra:



