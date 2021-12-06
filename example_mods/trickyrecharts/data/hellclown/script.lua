--Last Edited 10/12/21 by SaturnSpades
--Tricky mod credits will be put here temporarily until in-game credits can be modified within Lua
--Tricky Mod Developers: Banbuds, Rosebud, KadeDev, CVal, YingYang48, JADS, Moro
--Special Thanks: Tom Fulp, Krinkels, GWebDev, Tsuraran
local allowCutscene = false
local allowCountdown = false
function onStartCountdown()
    -- Block the first countdown and start cutscene
    if not allowCountdown and allowCutscene and not seenCutscene then
        startVideo('HellClownIntro')
	    allowCountdown = true;
        return Function_Stop;
    end
	return Function_Continue;
end
function onCreate()

    --Adds Lua Sprites
    addCharacterToList('signDeath', 'boyfriend');

    makeLuaSprite('TrickyStatic', 'TrickyStatic', -580, -90);
    scaleLuaSprite('TrickyStatic', 10, 10);
    addLuaSprite('TrickyStatic', true)
    setPropertyLuaSprite('TrickyStatic', 'alpha', 0)

    makeAnimatedLuaSprite('signDeath', 'signDeath');
    luaSpriteAddAnimationByPrefix('signDeath', 'bfDies', 'BF dies', 24, false)
    luaSpriteAddAnimationByPrefix('signDeath', 'bfDeadLoop', 'BF Dead Loop', 24, true)
    luaSpriteAddAnimationByPrefix('signDeath', 'bfDeadConfirm', 'BF Dead confirm', 24, false)

    makeAnimatedLuaSprite('Hank', 'Hank', 700, 410)
    addAnimationByPrefix('Hank', 'Hank', 'Hank', 24, true)
    addLuaSprite('Hank', false)
    objectPlayAnimation('Hank', 'Hank')
 
    setPropertyFromClass('GameOverSubstate', 'characterName', 'signDeath')   
end

function opponentNoteHit(id, direction, noteType, isSustainNote)

    local luckyRoll = math.random(1, 30)

    if (luckyRoll >= 15 and curStep <= 2805 and curStep >= 160) then
        runTimer('static', 0, 1)
        runTimer('TrickyAlpha', 0.1, 1)
	end

    cameraShake('game', 0.01, 0.1)
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    runTimer('TrickyAlpha', 0.05, 1)
end

function onTimerCompleted(tag, loops, loopsLeft)

    if tag == 'TrickyAlpha' then
        setPropertyLuaSprite('TrickyStatic', 'alpha', 0)
    end

    if tag == 'static' then
        playSound('staticSound')
        setPropertyLuaSprite('TrickyStatic', 'alpha', 0.2)
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

function onGameOverConfirm(retry)
	-- Called when you Press Enter/Esc on Game Over
	-- If you've pressed Esc, value "retry" will be false
    setProperty('boyfriend.curCharacter', 'signDeath')
    luaSpritePlayAnimation('bfDeadConfirm')
    playMusic('gameOverEnd', 1, true)
end

function onEndSong()
    if isStoryMode and not seenCutscene then
        startVideo('HellClownOutro')
        seenCutscene = true
        return Function_Stop
    end
    return Function_Continue
end