# This imports all the layers for "Diary" into diaryLayers1
diaryLayers = Framer.Importer.load "imported/Diary"

diaryContainer = new Layer
	width: Screen.width
	height: Screen.height
	backgroundColor: "white"
	scale: 0
	opacity: 0

diaryContainer.states.animationOptions = {
    curve: "ease-in-out"
    repeat: 0
    delay: 0
    time: 0.4
}

clickCount = 0
diaryContainer.on Events.Click, ->
	clickCount += 1 
	if clickCount == 2
		diaryContainer.states.switch("fadeOut")
		clickCount = 0

diaryContainer.states.add
    default: {opacity:0, scale: 0}
    show: {opacity:1, scale: 1}
    fadeOut: {opacity:0, scale: 2.0}

diaryContainer.center()

diaryLayers.View.visible = true
diaryLayers.View.superLayer = diaryContainer
# Create layer
container = new Layer
	width: Screen.width
	height: Screen.height
	backgroundColor: "#fff"

container.center()

diaryLayers.Month.visible = true
diaryLayers.Month.superLayer = container

diaryLayers.Month.on Events.Click, ->
	diaryContainer.bringToFront()
	diaryContainer.states.switch("show")