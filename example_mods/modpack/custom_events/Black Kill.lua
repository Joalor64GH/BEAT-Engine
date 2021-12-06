local thePlayerIsDead = false
function onEvent(name, val1, val2)--what happens when the event is triggered
    --debugPrint(name)
    if name == 'Black Kill' then
        thePlayerIsDead = true--set the target
        runTimer('soundPlay', 0.4)  --run timer for sound to play at correct time
        triggerEvent('Play Animation', 'kill', 'amonger')   --play blacks kill animation
        doTweenZoom('you are dead', 'camGame', 1.4, 1.4, 'linear')  --zoom the camera
    end
end

function onCreatePost()
    doTweenAlpha('bye camera', 'camHUD', 0, 0.8, 'linear')  --make camhud invisible
end

function onUpdate(elapsed)
    if getProperty('dad.animation.curAnim.name') == 'kill' and getProperty('dad.animation.curAnim.finished') then
        setProperty('health', 0)    --you die when black animation is kill and its finished
    end

    if thePlayerIsDead then
        cameraSetTarget('dad')  --sets camera target to black
        setProperty('vocals.volume', 0) --no more bf
    end
end

function onTimerCompleted(name, lo, lop)--plays the death sound
    if name == 'soundPlay' then
        playSound('black-death')
    end
end