--Last Edited 10/12/21 by SaturnSpades
local allowCountdown = false
local allowCutscene = false
function onStartCountdown()
    -- Block the first countdown and start cutscene
    if not allowCountdown and allowCutscene and not seenCutscene then
        setProperty('inCutscene', true)
        setProperty('dad.alpha', 0)
        setProperty('gf.alpha', 0)
        setProperty('boyfriend.visible', false)
        setProperty('camFollowPos.x', 1250)
        setProperty('camFollowPos.y', 600)
        setProperty('camHUD.visible', false)
        playSound('wind')
        runTimer('somewhere', 0.5, 1);
        runTimer('somewhereAlpha', 2, 1);
        runTimer('playSounds', 4.85, 1)
        runTimer('introAlpha', 4.35, 1)
        runTimer('introTricky', 1, 1)
        runTimer('moveCamera', 6, 1)
        runTimer('CutsceneString', 7.5, 1)
        runTimer('omfgalpha', 9, 1)
        runTimer('playTrigger', 9, 1)
        runTimer('doFadeOut', 10, 1)
        runTimer('changeScene', 11, 1)
        runTimer('doFadeIn', 12, 1)
        runTimer('startCount', 14, 1);
	    allowCountdown = true;
        return Function_Stop;
    end
    setProperty('camHUD.visible', true)
	return Function_Continue;
end
function onCreate()

    --Adds Lua Sprites
    addCharacterToList('signDeath', 'boyfriend');
    precacheSound('ground')
    precacheSound('wind')
    precacheSound('cloth')
    precacheSound('metal')
    precacheSound('trickyIsTriggered')

    makeLuaSprite('TrickyStatic', 'TrickyStatic', -380, -90);
    scaleLuaSprite('TrickyStatic', 10, 10);
    addLuaSprite('TrickyStatic', true)
    setPropertyLuaSprite('TrickyStatic', 'alpha', 0)

    makeAnimatedLuaSprite('signDeath', 'signDeath');
    luaSpriteAddAnimationByPrefix('signDeath', 'bfDies', 'BF dies', 24, false)
    luaSpriteAddAnimationByPrefix('signDeath', 'bfDeadLoop', 'BF Dead Loop', 24, true)
    luaSpriteAddAnimationByPrefix('signDeath', 'bfDeadConfirm', 'BF Dead confirm', 24, false)

    makeAnimatedLuaSprite('TrickyStrings', 'TrickyStrings', 160, 580);
    luaSpriteAddAnimationByIndices('TrickyStrings', 'Suffer', 'Strings', 0)
    luaSpriteAddAnimationByIndices('TrickyStrings', 'Incorrect', 'Strings', 1)
    luaSpriteAddAnimationByIndices('TrickyStrings', 'Incomplete', 'Strings', 2)
    luaSpriteAddAnimationByIndices('TrickyStrings', 'Insufficient', 'Strings', 3)
    luaSpriteAddAnimationByIndices('TrickyStrings', 'Invalid', 'Strings', 4)
    luaSpriteAddAnimationByIndices('TrickyStrings', 'Correction', 'Strings', 5)
    luaSpriteAddAnimationByIndices('TrickyStrings', 'Mistake', 'Strings', 6)
    luaSpriteAddAnimationByIndices('TrickyStrings', 'Reduce', 'Strings', 7)
    luaSpriteAddAnimationByIndices('TrickyStrings', 'Error', 'Strings', 8)
    luaSpriteAddAnimationByIndices('TrickyStrings', 'Adjusting', 'Strings', 9)
    luaSpriteAddAnimationByIndices('TrickyStrings', 'Improbable', 'Strings', 10)
    luaSpriteAddAnimationByIndices('TrickyStrings', 'Implausible', 'Strings', 11)
    luaSpriteAddAnimationByIndices('TrickyStrings', 'Misjudged', 'Strings', 12)
    scaleLuaSprite('TrickyStrings', 1.5, 1.5)
    addLuaSprite('TrickyStrings', true)
    setPropertyLuaSprite('TrickyStrings', 'alpha', 0)

    makeAnimatedLuaSprite('TrickyMissStrings', 'TrickyMissStrings', 160, 580);
    luaSpriteAddAnimationByIndices('TrickyMissStrings', 'Terrible', 'Strings', 0)
    luaSpriteAddAnimationByIndices('TrickyMissStrings', 'Waste', 'Strings', 1)
    luaSpriteAddAnimationByIndices('TrickyMissStrings', 'Miss Calculated', 'Strings', 2)
    luaSpriteAddAnimationByIndices('TrickyMissStrings', 'Predicted', 'Strings', 3)
    luaSpriteAddAnimationByIndices('TrickyMissStrings', 'Failure', 'Strings', 4)
    luaSpriteAddAnimationByIndices('TrickyMissStrings', 'Disgusting', 'Strings', 5)
    luaSpriteAddAnimationByIndices('TrickyMissStrings', 'Abhorrent', 'Strings', 6)
    luaSpriteAddAnimationByIndices('TrickyMissStrings', 'Foreseen', 'Strings', 7)
    luaSpriteAddAnimationByIndices('TrickyMissStrings', 'Contemptible', 'Strings', 8)
    luaSpriteAddAnimationByIndices('TrickyMissStrings', 'Prognosticate', 'Strings', 9)
    luaSpriteAddAnimationByIndices('TrickyMissStrings', 'Dispicable', 'Strings', 10)
    luaSpriteAddAnimationByIndices('TrickyMissStrings', 'Reprehensible', 'Strings', 11)
    luaSpriteAddAnimationByIndices('TrickyMissStrings', 'Unsurprising', 'Strings', 12)
    luaSpriteAddAnimationByIndices('TrickyMissStrings', 'Predetermined', 'Strings', 13)
    scaleLuaSprite('TrickyMissStrings', 2.3, 2.3)
    addLuaSprite('TrickyMissStrings', true)
    setPropertyLuaSprite('TrickyMissStrings', 'alpha', 0)
 
    setPropertyFromClass('GameOverSubstate', 'characterName', 'signDeath')

    --cutscene sprites
        makeLuaSprite('Black', '', -550, -100)
        luaSpriteMakeGraphic('Black', 3000, 3000, '000000')
        addLuaSprite('Black', true)
        --setPropertyLuaSprite('Black', 'alpha', 1)
        setPropertyLuaSprite('Black', 'alpha', 0)
        blackAlpha = 1
        blackOutAlpha = 0

        makeLuaSprite('White', '', -550, -100)
        luaSpriteMakeGraphic('White', 3000, 3000, 'FFFFFF')
        addLuaSprite('White', true)
        setPropertyLuaSprite('White', 'alpha', 0)
        whiteAlpha = 0

        setObjectOrder('Black', 30)
        setObjectOrder('White', 30)

        makeAnimatedLuaSprite('bf', 'BOYFRIEND', 890, 450)
        luaSpriteAddAnimationByPrefix('bf', 'idle', 'BF idle dance', 24, true)
        luaSpriteAddAnimationByPrefix('bf', 'shaking', 'BF idle shaking', 24, true)
        addLuaSprite('bf', true)
        setObjectOrder('bf', 5)
        luaSpritePlayAnimation('bf', 'idle')
        setPropertyLuaSprite('bf', 'alpha', 0)

        makeAnimatedLuaSprite('girlfriend', 'GF_assets', 400, 130)
        luaSpriteAddAnimationByPrefix('girlfriend', 'idle', 'GF Dancing Beat', 24, true)
        addLuaSprite('girlfriend')
        setPropertyLuaSprite('girlfriend', 'alpha', 0)

        makeAnimatedLuaSprite('somewhere', 'somewhere', 700, 530)
        luaSpriteAddAnimationByPrefix('somewhere', 'somewhere', 'somewhere', 24, false)
        scaleLuaSprite('somewhere', 0.5, 0.5)

        makeAnimatedLuaSprite('omfgclown', 'omfgclown', 140, 630)
        luaSpriteAddAnimationByPrefix('omfgclown', 'omfgclown', 'Strings0001', 24)
        setPropertyLuaSprite('omfgclown', 'alpha', 0)
        scaleLuaSprite('omfgclown', 2, 2)
        addLuaSprite('omfgclown', true)
        --setObjectOrder('omfgclown', 10)

        makeLuaSprite('red', 'red', 300, 30)
        addLuaSprite('red', true)
        setPropertyLuaSprite('red', 'alpha', 0)
        redAlpha = 1
        
        makeAnimatedLuaSprite('intro', 'intro', -130, 250)
        luaSpriteAddAnimationByPrefix('intro', 'intro', 'Symbol', 24, false)
        


        setPropertyLuaSprite('intro', 'alpha', 0)
        --makeAnimatedLuaSprite('jaws', 'Jaws', 0, 0)
        --luaSpriteAddAnimationByPrefix('close', 'Jaws smol', 24, false)
        
end


trickyStrings = {
    [0] = function()
        luaSpritePlayAnimation('TrickyStrings', 'Suffer')
        runTimer('stringAngles', 0.02, 90)
    end,

    [1] = function()
        luaSpritePlayAnimation('TrickyStrings', 'Incorrect')
        runTimer('stringAngles', 0.02, 90)
    end,

    [2] = function()
        luaSpritePlayAnimation('TrickyStrings', 'Incomplete')
        runTimer('stringAngles', 0.02, 90)
    end,

    [3] = function()
        luaSpritePlayAnimation('TrickyStrings', 'Insufficient')
        runTimer('stringAngles', 0.02, 90)
    end,

    [4] = function()
        luaSpritePlayAnimation('TrickyStrings', 'Invalid')
        runTimer('stringAngles', 0.02, 90)
    end,

    [5] = function()
        luaSpritePlayAnimation('TrickyStrings', 'Correction')
        runTimer('stringAngles', 0.02, 90)
    end,

    [6] = function()
        luaSpritePlayAnimation('TrickyStrings', 'Mistake')
        runTimer('stringAngles', 0.02, 90)
    end,

    [7] = function()
        luaSpritePlayAnimation('TrickyStrings', 'Reduce')
        runTimer('stringAngles', 0.02, 90)
    end,

    [8] = function()
        luaSpritePlayAnimation('TrickyStrings', 'Error')
        runTimer('stringAngles', 0.02, 90)
    end,

    [9] = function()
        luaSpritePlayAnimation('TrickyStrings', 'Adjusting!')
        runTimer('stringAngles', 0.02, 90)
    end,

    [10] = function()
        luaSpritePlayAnimation('TrickyStrings', 'Improbable')
        runTimer('stringAngles', 0.02, 90)
    end,

    [11] = function()
        luaSpritePlayAnimation('TrickyStrings', 'Implausible')
        runTimer('stringAngles', 0.02, 90)
    end,

    [12] = function()
        luaSpritePlayAnimation('TrickyStrings', 'Misjudged')
        runTimer('stringAngles', 0.02, 90)
    end,
}

trickyMissStrings = {
    [0] = function()
        luaSpritePlayAnimation('TrickyMissStrings', 'Terrible')
        runTimer('stringMissAngles', 0.02, 90)
    end,

    [1] = function()
        luaSpritePlayAnimation('TrickyMissStrings', 'Waste')
        runTimer('stringMissAngles', 0.02, 90)
    end,

    [2] = function()
        luaSpritePlayAnimation('TrickyMissStrings', 'Miss Calculated')
        runTimer('stringMissAngles', 0.02, 90)
    end,

    [3] = function()
        luaSpritePlayAnimation('TrickyMissStrings', 'Predicted')
        runTimer('stringMissAngles', 0.02, 90)
    end,

    [4] = function()
        luaSpritePlayAnimation('TrickyMissStrings', 'Failure')
        runTimer('stringMissAngles', 0.02, 90)
    end,

    [5] = function()
        luaSpritePlayAnimation('TrickyMissStrings', 'Disgusting')
        runTimer('stringMissAngles', 0.02, 90)
    end,

    [6] = function()
        luaSpritePlayAnimation('TrickyMissStrings', 'Abhorrent')
        runTimer('stringMissAngles', 0.02, 90)
    end,

    [7] = function()
        luaSpritePlayAnimation('TrickyMissStrings', 'Foreseen')
        runTimer('stringMissAngles', 0.02, 90)
    end,

    [8] = function()
        luaSpritePlayAnimation('TrickyMissStrings', 'Contemptible')
        runTimer('stringMissAngles', 0.02, 90)
    end,

    [9] = function()
        luaSpritePlayAnimation('TrickyMissStrings', 'Prognosticate')
        runTimer('stringMissAngles', 0.02, 90)
    end,

    [10] = function()
        luaSpritePlayAnimation('TrickyMissStrings', 'Dispicable')
        runTimer('stringMissAngles', 0.02, 90)
    end,

    [11] = function()
        luaSpritePlayAnimation('TrickyMissStrings', 'Reprehensible')
        runTimer('stringMissAngles', 0.02, 90)
    end,

    [12] = function()
        luaSpritePlayAnimation('TrickyMissStrings', 'Unsurprising')
        runTimer('stringMissAngles', 0.02, 90)
    end,

    [13] = function()
        luaSpritePlayAnimation('TrickyMissStrings', 'Predetermined')
        runTimer('stringMissAngles', 0.02, 90)
    end,
}

trickyCutsceneStrings = {
    [1] = function()
        luaSpritePlayAnimation('omfgclown', 'omfgclown')
        runTimer('stringCutSceneAngles', 0.02, 500)
    end,
}

function opponentNoteHit(id, direction, noteType, isSustainNote)

    local luckyRoll = math.random(1, 65)

    if (luckyRoll >= 60 and isSustainNote == false) then
        runTimer('TrickyStringTime', 0, 1)
        runTimer('TrickyAlpha', 0.3, 1)
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    runTimer('TrickyAlpha2', 0.3, 1)
end

function noteMiss()
    runTimer('TrickyAlpha2', 0.3, 1)
    local unluckyRoll = math.random(1, 70)
    if unluckyRoll >= 65 then
        runTimer('TrickyMissString', 0, 1)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
	
    if tag == 'TrickyStringTime' then
        playSound('staticSound')
        setPropertyLuaSprite('TrickyStatic', 'alpha', 0.2)
        setPropertyLuaSprite('TrickyStrings', 'alpha', 1)
        counter = math.random(0, 12)
        trickyStrings[counter]()
	end

    if tag == 'TrickyMissString' then
        playSound('staticSound')
        setPropertyLuaSprite('TrickyStatic', 'alpha', 0.2)
        setPropertyLuaSprite('TrickyMissStrings', 'alpha', 1)
        misscounter = math.random(0, 13)
        trickyMissStrings[misscounter]()
        runTimer('TrickyMissAlpha', 0.33, 1)
	end

    if tag == 'CutsceneString' then
        playSound('staticSound')
        setPropertyLuaSprite('TrickyStatic', 'alpha', 0.2)
        setPropertyLuaSprite('omfgclown', 'alpha', 1)
        trickyCutsceneStrings[1]()
    end

    if tag == 'TrickyAlpha' then
        setPropertyLuaSprite('TrickyStatic', 'alpha', 0)
        setPropertyLuaSprite('TrickyStrings', 'alpha', 0)
    end
    
    if tag == 'TrickyAlpha2' then
        setPropertyLuaSprite('TrickyStatic', 'alpha', 0)
        setPropertyLuaSprite('TrickyStrings', 'alpha', 0)
    end
    
    if tag == 'staticAlpha' then
        setPropertyLuaSprite('TrickyStatic', 'alpha', 0)
    end

    if tag == 'staticAlphaOff' then
        playSound('staticSound')
        setPropertyLuaSprite('TrickyStatic', 'alpha', 0)
    end

    if tag == 'omfgalpha' then
        runTimer('staticAlphaOff', 0, 1)
        setPropertyLuaSprite('omfgclown', 'alpha', 0)
    end

    if tag == 'TrickyMissAlpha' then
        setPropertyLuaSprite('TrickyStatic', 'alpha', 0)
        setPropertyLuaSprite('TrickyMissStrings', 'alpha', 0)
    end

    if tag == 'stringAngles' then
        setStringAngle = math.random(-5,5)
        setProperty('TrickyStrings.angle', setStringAngle)
    end

    if tag == 'stringMissAngles' then
        setStringAngle = math.random(-5,5)
        setProperty('TrickyMissStrings.angle', setStringAngle)
    end

    if tag == 'stringCutSceneAngles' then
        setStringAngle = math.random(-5,5)
        setProperty('omfgclown.angle', setStringAngle)
    end

    if tag == 'trickyglitch' then
        playSound('TrickyGlitch')
    end

    if tag == 'fadeIn' then
        blackAlpha = blackAlpha - 0.1
        setPropertyLuaSprite('Black', 'alpha', blackAlpha)

        if loopsLeft == 0 then
            runTimer('cutscene1', 0, 1)
        end
    end

    if tag == 'fadeOut' then
        blackOutAlpha = blackOutAlpha + 0.1
        --if blackAlpha > 1 then
        setPropertyLuaSprite('Black', 'alpha', blackOutAlpha)
    end

    if tag == 'fadeWhite' then
        whiteAlpha = whiteAlpha + 0.05
        setPropertyLuaSprite('White', 'alpha', whiteAlpha)
    end

    if tag == 'somewhere' then
        setPropertyLuaSprite('bf', 'alpha', 1)
        addLuaSprite('somewhere', true)
        setPropertyLuaSprite('red', 'alpha', 1)
        luaSpritePlayAnimation('somewhere', 'somewhere')
    end

    if tag == 'somewhereAlpha' then
        runTimer('doAlpha', 0.1, 10)
    end

    if tag == 'doAlpha' then
        redAlpha = redAlpha - 0.1
        setPropertyLuaSprite('red', 'alpha', redAlpha)
    end

    if tag == 'introTricky' then
        addLuaSprite('intro', false)
        luaSpritePlayAnimation('intro', 'intro')
        --setPropertyLuaSprite('intro', 'alpha', 1)
        
    end

    if tag == 'introAlpha' then
        setPropertyLuaSprite('intro', 'alpha', 1)
    end

    if tag == 'playSounds' then
        playSound('cloth')
        playSound('ground')
        playSound('metal')
    end

    if tag == 'moveCamera' then
        setProperty('inCutscene', false)
        setProperty('camFollow.x', 420)
        setProperty('camFollow.y', 750)
        runTimer('setZoom', 0.02, 40)
        
    end

    if tag == 'setZoom' then
        camZoom = getProperty('camera.zoom')
        if camZoom < 1.1 then
            camZoom = camZoom + 0.01
            setProperty('camera.zoom', camZoom)
        end
    end

    if tag == 'playTrigger' then
        setProperty('camera.zoom', 0.75)
        luaSpritePlayAnimation('bf', 'shaking')
        playSound('trickyIsTriggered', 1, 'triggered')
        cameraShake('game', 0.01, 2)
        soundFadeOut('triggered', 3, 0)
    end

    if tag == 'doFadeOut' then
        runTimer('fadeOut', 0.1, 10)
    end

    if tag == 'doFadeIn' then
        runTimer('fadeIn', 0.1, 10)
    end

    if tag == 'changeScene' then
        removeLuaSprite('bf')
        removeLuaSprite('intro')
        setProperty('dad.alpha', 1)
        setProperty('gf.alpha', 1)
        setProperty('boyfriend.visible', true)
        setProperty('camFollow.x', 400)
        setProperty('camFollow.y', 530)
    end

    if tag == 'startCount' then
        --removeLuaSprite('Black')
        --setProperty('dad.alpha', 1)
        startCountdown()
    end


end

function onGameOver()
	-- You died! Called every single frame your health is lower (or equal to) zero
	-- return Function_Stop if you want to stop the player from going into the game over screen
    setProperty('boyfriend.curCharacter', 'signDeath')
    playSound('death', 0.3)
    playSound('BF_Deathsound')
    playMusic('gameOver', 1, true)
	return Function_Continue;
end

function onGameOverConfirm()
	-- Called when you Press Enter/Esc on Game Over
	-- If you've pressed Esc, value "retry" will be false
    setProperty('boyfriend.curCharacter', 'signDeath')
    luaSpritePlayAnimation('bfDeadConfirm')
    playMusic('gameOverEnd', 1, true)
end

