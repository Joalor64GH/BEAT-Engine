--Last Edited 10/12/21 by SaturnSpades
local allowCountdown = false
local allowCutscene = false
function onStartCountdown()
    -- Block the first countdown and start Tricky Enter cutscene
    if not allowCountdown and allowCutscene and not seenCutscene then
        setProperty('inCutscene', true)
        setProperty('dad.alpha', 0)
        setProperty('camFollowPos.y', 550)
        setProperty('camHUD.visible', false)
	    runTimer('trickyEnters', 0.5);
        runTimer('startCount', 1.5);
	    allowCountdown = true;
        return Function_Stop;
    end
    setProperty('camHUD.visible', true)
	return Function_Continue;
end
function onCreate()
    --Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Instakill_Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'HURTNOTE_assets'); --Change texture

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			end
		end
	end
    --preload sprites
    addCharacterToList('signDeath', 'boyfriend');
    precacheImage('Sign_Post');
    precacheImage('HP GREMLIN');

    --Adds Lua Sprites
    makeLuaSprite('TrickyStatic', 'TrickyStatic', -180, -90);
    scaleLuaSprite('TrickyStatic', 10, 10);
    addLuaSprite('TrickyStatic', true)
    setPropertyLuaSprite('TrickyStatic', 'alpha', 0)

    makeAnimatedLuaSprite('floorSpikes', 'FloorSpikes', -15, 470);
    luaSpriteAddAnimationByPrefix('floorSpikes', 'Floor Spikes', 'Floor Spikes', 24, false);
    scaleLuaSprite('floorSpikes', 0.65, 0.65);
	luaSpritePlayAnimation('floorSpikes', 'Floor Spikes');
    addLuaSprite('floorSpikes', true);
    setPropertyLuaSprite('floorSpikes', 'alpha', 0);

    makeAnimatedLuaSprite('signPost', 'Sign_Post', 860, -120);
    luaSpriteAddAnimationByPrefix('signPost', 'Sign1', 'Signature Stop Sign 1', 24, false)
    makeAnimatedLuaSprite('signPost3', 'Sign_Post', 1255, -520);
    luaSpriteAddAnimationByPrefix('signPost3', 'Sign3', 'Signature Stop Sign 3', 24, false)
    makeAnimatedLuaSprite('signPost4', 'Sign_Post', 933, -170);
    luaSpriteAddAnimationByPrefix('signPost4', 'Sign4', 'Signature Stop Sign 4', 24, false)
  
    scaleLuaSprite('signPost', 0.7, 0.7)
    setLuaSpriteCamera('signPost', 'camHUD')
    scaleLuaSprite('signPost3', 0.7, 0.7)
    setLuaSpriteCamera('signPost3', 'camHUD')
    scaleLuaSprite('signPost4', 0.7, 0.7)
    setLuaSpriteCamera('signPost4', 'camHUD')

    addLuaSprite('signPost', true)
    setProperty('signPost.angle', -90)
    setPropertyLuaSprite('signPost', 'alpha', 0)
    addLuaSprite('signPost3', true)
    setProperty('signPost3.angle', -90)
    setPropertyLuaSprite('signPost3', 'alpha', 0)
    addLuaSprite('signPost4', true)
    setProperty('signPost4.angle', -90)
    setPropertyLuaSprite('signPost4', 'alpha', 0)

    makeAnimatedLuaSprite('Clone', 'Clone', 50, 550);
    luaSpriteAddAnimationByPrefix('Clone', 'Clone', 'Clone', 24, false);
    scaleLuaSprite('Clone', 0.55, 0.55);
    addLuaSprite('Clone', false);
    setPropertyLuaSprite('Clone', 'alpha', 0)

    makeAnimatedLuaSprite('Clone2', 'Clone', 360, 480);
    luaSpriteAddAnimationByPrefix('Clone2', 'Clone2', 'Clone', 24, false);
    scaleLuaSprite('Clone2', 0.55, 0.55);
    addLuaSprite('Clone2', false);
    setPropertyLuaSprite('Clone2', 'alpha', 0)

    makeAnimatedLuaSprite('signDeath', 'signDeath');
    luaSpriteAddAnimationByPrefix('signDeath', 'bfDies', 'BF dies', 24, false)
    luaSpriteAddAnimationByPrefix('signDeath', 'bfDeadLoop', 'BF Dead Loop', 24, true)
    luaSpriteAddAnimationByPrefix('signDeath', 'bfDeadConfirm', 'BF Dead confirm', 24, false)

    makeAnimatedLuaSprite('ExTrickyStrings', 'ExTrickyStrings', 160, 480);
    luaSpriteAddAnimationByIndices('ExTrickyStrings', 'notHank', 'Strings', 0)
    luaSpriteAddAnimationByIndices('ExTrickyStrings', 'whereHank', 'Strings', 1)
    luaSpriteAddAnimationByIndices('ExTrickyStrings', 'Hank?', 'Strings', 2)
    luaSpriteAddAnimationByIndices('ExTrickyStrings', 'whoAreYou', 'Strings', 3)
    luaSpriteAddAnimationByIndices('ExTrickyStrings', 'whereAmI', 'Strings', 4)
    luaSpriteAddAnimationByIndices('ExTrickyStrings', 'notRight', 'Strings', 5)
    luaSpriteAddAnimationByIndices('ExTrickyStrings', 'midget', 'Strings', 6)
    luaSpriteAddAnimationByIndices('ExTrickyStrings', 'systemUnresponsive', 'Strings', 7)
    luaSpriteAddAnimationByIndices('ExTrickyStrings', 'whyCantKill', 'Strings', 8)
    luaSpriteAddAnimationByIndices('ExTrickyStrings', 'criticalFailure', 'Strings', 9)
    luaSpriteAddAnimationByIndices('ExTrickyStrings', 'Hank!', 'Strings', 10)
    luaSpriteAddAnimationByIndices('ExTrickyStrings', 'bringHank', 'Strings', 11)
    scaleLuaSprite('ExTrickyStrings', 1.5, 1.5)
    addLuaSprite('ExTrickyStrings', true)
    setPropertyLuaSprite('ExTrickyStrings', 'alpha', 0)

    --Sets Clones in front of extricky and behind spawnhole cover
    setObjectOrder('Clone', 10)
    setObjectOrder('Clone2', 10)
 
    setPropertyFromClass('GameOverSubstate', 'characterName', 'signDeath')
    --setProperty('health', 2)
end

beatem = 0
beatem1 = 0
lastStep = 0
flipped = false
hpToTake = 0
startHealth = 0
toHealth = 0
lerpPercent = 0
gremduration = 0
perc = 0
loopsCompleted = 0
onc = false
interupt = false
grabbed = false

trickyStrings = {
    [0] = function()
        luaSpritePlayAnimation('ExTrickyStrings', 'notHank')
        runTimer('stringAngles', 0.02, 90)
    end,

    [1] = function()
        luaSpritePlayAnimation('ExTrickyStrings', 'whereHank')
        runTimer('stringAngles', 0.02, 90)
    end,

    [2] = function()
        luaSpritePlayAnimation('ExTrickyStrings', 'Hank?')
        runTimer('stringAngles', 0.02, 90)
    end,

    [3] = function()
        luaSpritePlayAnimation('ExTrickyStrings', 'whoAreYou')
        runTimer('stringAngles', 0.02, 90)
    end,

    [4] = function()
        luaSpritePlayAnimation('ExTrickyStrings', 'whereAmI')
        runTimer('stringAngles', 0.02, 90)
    end,

    [5] = function()
        luaSpritePlayAnimation('ExTrickyStrings', 'notRight')
        runTimer('stringAngles', 0.02, 90)
    end,

    [6] = function()
        luaSpritePlayAnimation('ExTrickyStrings', 'midget')
        runTimer('stringAngles', 0.02, 90)
    end,

    [7] = function()
        luaSpritePlayAnimation('ExTrickyStrings', 'systemUnresponsive')
        runTimer('stringAngles', 0.02, 90)
    end,

    [8] = function()
        luaSpritePlayAnimation('ExTrickyStrings', 'whyCantKill')
        runTimer('stringAngles', 0.02, 90)
    end,

    [9] = function()
        luaSpritePlayAnimation('ExTrickyStrings', 'criticalFailure')
        runTimer('stringAngles', 0.02, 90)
    end,

    [10] = function()
        luaSpritePlayAnimation('ExTrickyStrings', 'Hank!')
        runTimer('stringAngles', 0.02, 90)
    end,

    [11] = function()
        luaSpritePlayAnimation('ExTrickyStrings', 'bringHank')
        runTimer('stringAngles', 0.02, 90)
    end,
}

stopSigns = {
    [1] = function(flipped)
        setProperty('signPost.flipX', flipped)
        setPropertyLuaSprite('signPost', 'alpha', 1)
        luaSpritePlayAnimation('signPost', 'Sign1')
        flipped = false
    end,

    [2] = function(flipped)
        setProperty('signPost3.flipX', flipped)
        setPropertyLuaSprite('signPost3', 'alpha', 1)
        luaSpritePlayAnimation('signPost3', 'Sign3')
        flipped = false
    end,

    [3] = function(flipped)
        setProperty('signPost4.flipX', flipped)
        setPropertyLuaSprite('signPost4', 'alpha', 1)
        luaSpritePlayAnimation('signPost4', 'Sign4')
        flipped = false
    end,
}

songEvents = {
    [20] = function()
        gremlinx = getProperty('iconP1.x')
        gremliny = getProperty('healthBarBG.y') - 215
        makeAnimatedLuaSprite('HPGremlin', 'HP GREMLIN', gremlinx, gremliny);
        luaSpriteAddAnimationByIndices('HPGremlin', 'come', 'HP Gremlin ANIMATION', '0,1')
        luaSpriteAddAnimationByIndices('HPGremlin', 'grab', 'HP Gremlin ANIMATION', '2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24')
        luaSpriteAddAnimationByIndices('HPGremlin', 'hold', 'HP Gremlin ANIMATION', '25,26,27,28')
        luaSpriteAddAnimationByIndices('HPGremlin', 'release', 'HP Gremlin ANIMATION', '29,30,31,32,33')
        scaleLuaSprite('HPGremlin', 0.7, 0.7);
    end,
    [359] = function()
        gremlinevent(40, 3)
    end,
    [384] = function()
        stopSigns[1]()
    end,
    [511] = function()
        stopSigns[2]()
        stopSigns[1]()
    end,
    [610] = function()
        stopSigns[3]()
    end,
    [720] = function()
        stopSigns[2]()
    end,
    [750] = function()
        gremlinevent(40, 3)
    end,
    [991] = function()
        stopSigns[3]()
    end,
    [1140] = function()
        gremlinevent(40, 3)
    end,
    [1184] = function()
        stopSigns[2]()
    end,
    [1200] = function()
        stopSigns[3](true)
    end,
    [1218] = function()
        stopSigns[1]()
    end,
    [1235] = function()
        stopSigns[1](true)
    end,
    [1328] = function()
        stopSigns[1](true)
        stopSigns[2]()
    end,
    [1439] = function()
        stopSigns[3](true)
    end,
    [1520] = function()
        gremlinevent(40, 3)
    end,
    [1567] = function()
        stopSigns[1]()
    end,
    [1584] = function()
        stopSigns[1](true)
    end,
    [1600] = function()
        stopSigns[2]()
    end,
    [1706] = function()
        stopSigns[3]()
    end,
    [1900] = function()
        gremlinevent(40, 3)
    end,
    [1917] = function()
        stopSigns[1]()
    end,
    [1923] = function()
        stopSigns[1](true)
    end,
    [1927] = function()
        stopSigns[1]()
    end,
    [1932] = function()
        stopSigns[1](true)
    end,
    [2032] = function()
        stopSigns[2]()
        stopSigns[1]()
    end,
    [2036] = function()
        stopSigns[1](true)
    end,
    [2162] = function()
        stopSigns[2]()
        stopSigns[3]()
    end,
    [2193] = function()
        stopSigns[1]()
    end,
    [2202] = function()
        stopSigns[1](true)
    end,
    [2239] = function()
        stopSigns[2](true)
    end,
    [2258] = function()
        stopSigns[1](true)
    end,
    [2280] = function()
        gremlinevent(40, 3)
    end,
    [2304] = function()
        stopSigns[1](true)
        stopSigns[1]()
    end,
    [2326] = function()
        stopSigns[1](true)
    end,
    [2336] = function()
        stopSigns[3]()
    end,
    [2447] = function()
        stopSigns[2]()
        stopSigns[1](true)
        stopSigns[1]()
    end,
    [2480] = function()
        stopSigns[1](true)
        stopSigns[1]()
    end,
    [2512] = function()
        stopSigns[2]()
        stopSigns[1](true)
        stopSigns[1]()
    end,
    [2544] = function()
        stopSigns[1](true)
        stopSigns[1]()
    end,
    [2575] = function()
        stopSigns[2]()
        stopSigns[1](true)
        stopSigns[1]()
    end,
    [2604] = function()
        stopSigns[1](true)
    end,
    [2608] = function()
        stopSigns[1](true)
        stopSigns[1]()
    end,
    [2660] = function()
        gremlinevent(20, 13)
    end,

}

function gremlinevent(hpToTake, duration)
    gremduration = duration
    interupt = false
    grabbed = true
    
    if downscroll == true then
        setProperty('HPGremlin.flipY', true)
        gremlinflip = getProperty('HPGremlin.y') - 150
        setProperty('HPGremlin.y', gremlinflip)
    end
    addLuaSprite('HPGremlin', true)
    setPropertyLuaSprite('HPGremlin', 'alpha', 0)
    setLuaSpriteCamera('HPGremlin', 'camHUD')
    startHealth = getProperty('health')
    toHealth = (hpToTake / 100) * startHealth
    --debugPrint('tohealth = ', toHealth)
    perc = toHealth / 2 * 100
    --debugPrint('perc = ', perc)
    onc = false

    setPropertyLuaSprite('HPGremlin', 'alpha', 1)
    playSound('GremlinWoosh')
    luaSpritePlayAnimation('HPGremlin', 'come')
    runTimer('gremlingrab', 0.14, 1)
    
end

function onBeatHit()
	-- triggered 4 times per section

    cloneRandom1 = math.random(1, 125)
    cloneRandom2 = math.random(1, 125)

    if cloneRandom1 >= 115 then
        setPropertyLuaSprite('Clone', 'alpha', 1);		    
        luaSpritePlayAnimation('Clone', 'Clone');
    end

    if cloneRandom2 >= 115 then
        setPropertyLuaSprite('Clone2', 'alpha', 1);		    
        luaSpritePlayAnimation('Clone2', 'Clone2');
    end
end

function onStepHit()
    if curStep ~= lastStep then
        if songEvents[curStep] then
            songEvents[curStep]()
        end
        lastStep = curStep
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if (direction == 2) then
        setPropertyLuaSprite('floorSpikes', 'alpha', 1)
        luaSpritePlayAnimation('floorSpikes', 'Floor Spikes');
    end

    local luckyRoll = math.random(1, 50)
   
    if (luckyRoll >= 45) then
        runTimer('TrickyStringTime', 0, 1)
        runTimer('TrickyAlpha', 0.3, 1)
	end
   
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if noteType == 'Instakill_Note' and botPlay == false then
		setProperty('health', -500);
	end
    runTimer('TrickyAlpha2', 0.3, 1)
end

function noteMiss()
    interupt = true
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'hpDrain' then
        loopsCompleted = loopsCompleted + 1
        health = getProperty('health')
        --debugPrint(health)
        if health <= 0 then
            setProperty('health', -500)
        end
        luaSpritePlayAnimation('HPGremlin', 'hold')
        if(interupt == true and onc == false) then
            onc = true
            loopsCompleted = 0
            cancelTween('gremlinholding')
            
            luaSpritePlayAnimation('HPGremlin', 'release')
            runTimer('releaseTimer', 0.15, 1)
            cancelTimer('hpDrain')
        end
        if(interupt == false) then
            loopPercent = loopsCompleted / loops
            --debugPrint(loopPercent)
            hplerp = lerp(startHealth, toHealth, loopPercent)
            setProperty('health', hplerp)
        end
	end
	
    if tag == 'TrickyStringTime' then
        playSound('staticSound')
        setPropertyLuaSprite('TrickyStatic', 'alpha', 0.2)
        setPropertyLuaSprite('ExTrickyStrings', 'alpha', 1)
        counter = math.random(0, 11)
        trickyStrings[counter]()
	end

    if tag == 'TrickyAlpha' then
        setPropertyLuaSprite('TrickyStatic', 'alpha', 0)
        setPropertyLuaSprite('ExTrickyStrings', 'alpha', 0)
    end
    
    if tag == 'TrickyAlpha2' then
        setPropertyLuaSprite('TrickyStatic', 'alpha', 0)
        setPropertyLuaSprite('ExTrickyStrings', 'alpha', 0)
    end

    if tag == 'stringAngles' then
        setStringAngle = math.random(-5,5)
        setProperty('ExTrickyStrings.angle', setStringAngle)
    end

    if tag == 'sign4Alpha' then
        setPropertyLuaSprite('signPost4', 'alpha', 0)
    end
    
    if tag == 'trickyEnters' then
        makeAnimatedLuaSprite('EXENTER', 'EXENTER', -64, 190)
        luaSpriteAddAnimationByPrefix('EXENTER', 'Entrance', 'Entrance', 24, true)
        scaleLuaSprite('EXENTER', 0.7, 0.7);
        addLuaSprite('EXENTER')
        playSound('Trickyspawn')
        luaSpritePlayAnimation('EXENTER', 'Entrance')
        runTimer('trickyglitch', 0.7, 1)
    end

    if tag == 'gremlingrab' then
        luaSpritePlayAnimation('HPGremlin', 'grab')
        gremtween = getProperty('iconP1.x')
        remapToRange = 100 + (perc - 0) * (0 - 100) / (100 - 0)
        hpBarX = getProperty('healthBar.x')
        hpBarwidth = getProperty('healthBar.width')
        tweenlength = (hpBarX + (hpBarwidth * (remapToRange * 0.01) - 26)) - 75
        doTweenX('gremlingrabbing', 'HPGremlin', gremtween, 1, 'elasticIn')
        
    end

    if tag == 'releaseTimer' then
        removeLuaSprite('HPGremlin', false)
    end

    if tag == 'trickyglitch' then
        playSound('TrickyGlitch')
    end

    if tag == 'startCount' then
        removeLuaSprite('EXENTER')
        setProperty('dad.alpha', 1)
        startCountdown()
    end

end

function onTweenCompleted(tag)
    if tag == 'gremlingrabbing' then
        luaSpritePlayAnimation('HPGremlin', 'hold')
        timerDuration = gremduration / 0.1
        doTweenX('gremlinholding', 'HPGremlin', tweenlength, gremduration)
        runTimer('hpDrain', 0.1, timerDuration)
        
    end

    if tag == 'gremlinholding' then
        loopsCompleted = 0
        cancelTimer('hpDrain')
        if interupt == true then
            removeLuaSprite('HPGremlin', false)
            grabbed = false
        else
            luaSpritePlayAnimation('HPGremlin', 'release')
            runTimer('releaseTimer', 0.15, 1)
            grabbed = false
        end
    end
end

function lerp(pos1, pos2, perc)
    --return (1-perc) * pos1 + perc*pos2
    return pos1 + ((pos2 - pos1) * perc)
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
