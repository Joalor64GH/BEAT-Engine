local allowCountdown = false;
local bfSuper = false;
local spacePressed = false;
local deathLine;
local defaultCamPointX = 0;
local defaultCamPointY = 0;
local hover = false;
local cumzone = 0;

function onCreate()
    math.randomseed(os.time());
    deathLine = math.random(1, 11);
    precacheImage('characters/fleetway1');
    precacheImage('characters/fleetway2');
    precacheImage('characters/fleetway3');
    makeAnimatedLuaSprite('fleetwayAnims1', 'characters/fleetway1', 0, 0);
    makeAnimatedLuaSprite('fleetwayAnims2', 'characters/fleetway2', 0, 0);
    makeAnimatedLuaSprite('fleetwayAnims3', 'characters/fleetway3', 0, 0);
    addAnimationByPrefix('fleetwayAnims1', 'Step It Up', 'Fleetway StepItUp', 24, false);
    objectPlayAnimation('fleetwayAnims1', 'Step It Up', true);
    addAnimationByPrefix('fleetwayAnims1', 'Laugh', 'Fleetway Laugh', 24, false);
    objectPlayAnimation('fleetwayAnims1', 'Laugh', true);
    addAnimationByPrefix('fleetwayAnims1', 'Too Slow', 'Fleetway Too Slow', 24, false);
    objectPlayAnimation('fleetwayAnims1', 'Too Slow', true);
    addAnimationByPrefix('fleetwayAnims1', 'YoureFinished', 'Fleetway YoureFinished', 24, false);
    objectPlayAnimation('fleetwayAnims1', 'YoureFinished', true);
    addAnimationByPrefix('fleetwayAnims1', 'WHAT?!', 'Fleetway WHAT?!', 24, false);
    objectPlayAnimation('fleetwayAnims1', 'WHAT?!', true);
    addAnimationByPrefix('fleetwayAnims1', 'Grrr', 'Fleetway Grrr', 24, false);
    objectPlayAnimation('fleetwayAnims1', 'Grrr', true);
    addAnimationByPrefix('fleetwayAnims2', 'Show You', 'Fleetway Show You', 24, false);
    objectPlayAnimation('fleetwayAnims2', 'Show You', true);
    addAnimationByPrefix('fleetwayAnims2', 'Scream', 'Fleetway Scream', 24, false);
    objectPlayAnimation('fleetwayAnims2', 'Scream', true);
    addAnimationByPrefix('fleetwayAnims2', 'Growl', 'Fleetway Growl', 24, false);
    objectPlayAnimation('fleetwayAnims2', 'Growl', true);
    addAnimationByPrefix('fleetwayAnims2', 'Shut Up', 'Fleetway Shut Up', 24, false);
    objectPlayAnimation('fleetwayAnims2', 'Shut Up', true);
    addAnimationByPrefix('fleetwayAnims2', 'Right Alt', 'Fleetway Right Alt', 24, true);
    objectPlayAnimation('fleetwayAnims2', 'Right Alt', true);
    addAnimationByPrefix('fleetwayAnims3', 'Laser Blas', 'Fleetway Laser Blas', 24, false);
    objectPlayAnimation('fleetwayAnims3', 'Laser Blas', true);
    setProperty('fleetwayAnims1.visible', false);
    setProperty('fleetwayAnims2.visible', false);
    setProperty('fleetwayAnims3.visible', false);
    addLuaSprite('fleetwayAnims3', false);
    addLuaSprite('fleetwayAnims2', false);
    addLuaSprite('fleetwayAnims1', false);
    makeAnimatedLuaSprite('dodgy', 'fleetway/spacebar_icon', 200, 0);
    addAnimationByPrefix('dodgy', 'a', 'spacebar', 24, false);
    objectPlayAnimation('dodgy', 'a');
    setObjectCamera('dodgy', 'hud');
    addLuaSprite('dodgy', true);
    setProperty('dodgy.scale.x', 0.5);
    setProperty('dodgy.scale.y', 0.5);
    setProperty('dodgy.alpha', 0);
    setProperty('dodgy.active', true);
    precacheSound('robot');
    precacheSound('sonic');
    precacheSound('beam');
    precacheSound('SUPERBF');
    characterPlayAnim('dad', 'fastanim');
    
end

function onStartCountdown()
	if not allowCountdown then
        setProperty('camHUD.visible', 'false');
		setProperty('inCutscene', true);
        setProperty('dad.visible', false);
		setProperty('dad.x', 600);
        setProperty('dad.y', 400);
        setProperty('camFollow.x', 900);
        setProperty('camFollow.y', 700);
        cameraSetTarget('dad');
        setPropertyFromClass('FlxG', 'camera.zoom', 0.9);
        runTimer('starting', 1, 1);
        runTimer('falling', 2, 1);
        runTimer('beam', 6, 1);
		return Function_Stop;
	end
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'starting' then
        doTweenZoom('zooom', 'camGame', 1.5, 3, 'cubeOut');
        playSound('robot', 1);
    end
    if tag == 'falling' then
        playSound('sonic', 1);
        setProperty('thechamber.active', true);
        objectPlayAnimation('thechamber', 'a');
    end
    if tag == 'beam' then
        allowCountdown = true;
        cameraShake('game', 0.02, 0.2);
        setProperty('inCutscene', false);
        startCountdown();
        playSound('beam', 1);
        doTweenZoom('zoomie', 'camGame', 0.7, 0.2, 'cubeOut');
        objectPlayAnimation('floor', 'b', true);
        objectPlayAnimation('fleetwaybgshit', 'b', true);
        objectPlayAnimation('pebles', 'b', true);
        setProperty('emeraldbeamyellow.visible', true);
        removeLuaSprite('emeraldBeam');
    end
    if tag == 'death' then
        debugPrint(deathLine);
        soundFadeIn(nil, 0.3, 1, 0.4);
        playSound('FleetLines/'..deathLine, 1, 'joker');
    end
end

function onUpdate(elapsed)
    cumzone = cumzone + 0.03;
    setProperty('gf.visible', 'false');
    setProperty('gf.alpha', 0);
    setProperty('fleetwayAnims1.x', getProperty('dad.x'));
    setProperty('fleetwayAnims1.y', getProperty('dad.y'));
    setProperty('fleetwayAnims2.x', getProperty('dad.x'));
    setProperty('fleetwayAnims2.y', getProperty('dad.y'));
    setProperty('fleewatyAnims3.x', getProperty('dad.x'));
    setProperty('fleewatyAnims3.y', getProperty('dad.y'));
    if keyJustPressed('accept') and curStep > 267 and curStep < 272 then --dodgy check
        spacePressed = true;
    end
    if getProperty('dad.curCharacter') == 'fleetway' and hover then
        setProperty('dad.y', getProperty('dad.y') + math.sin(cumzone) * 1.3);
        if not mustHitSection then
            setProperty('camFollow.y', getProperty('camFollow.y') + math.sin(cumzone) * 1.3);
        end
    end
end

function onBeatHit()
    if mustHitSection then
        defaultCamPointX = getProperty('camFollow.x')
        defaultCamPointY = getProperty('camFollow.y');
    end
end

function onStepHit()
    --failsafes
    if curStep > 1008 and bfSuper and getProperty('boyfriend.curCharacter') == 'bfSuper' and getProperty('boyfriend.x') ~= 1700 then
        debugPrint('failsafe');
        setProperty('boyfriend.x', 1700);
        setProperty('boyfriend.y', getProperty('boyfriend.y')-200);
    end
    if curStep > 9 and curStep <= 64 and not getProperty('dad.visible') then
        setProperty('dad.visible', true);
    end
    if curStep > 272 and not spacePressed and not botPlay then --dodgy fail
        characterPlayAnim('boyfriend', 'idle', true);
        setPropertyFromClass('GameOverSubstate', 'characterName', 'bfFleetwayDeath');
        setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'laser_moment');
        setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'chaosgameover');
        setProperty('health', 0);
        runTimer('death', 1.4, 1);
    end
    if not getProperty('dad.visible') and getProperty('fleetwayAnims1.animation.finished') and getProperty('fleetwayAnims2.animation.finished') and getProperty('fleetwayAnims3.animation.finished') then
        resetStuff();
    end

    --cutscenes stuff
    if curStep == 15 then 
        doTweenX('dadx', 'dad', 61.15, 2, 'cubeOut');
        doTweenY('dady', 'dad', -94.75, 2, 'cubeOut');
    elseif curStep == 9 then
        setProperty('dad.visible', true);
        doTweenY('daddy', 'dad', getProperty('dad.y')-500, 0.5, 'cubeOut');
    elseif curStep == 64 then
        setProperty('camHUD.visible', true);
        --setProperty('camHUD.alpha', 0);
        --doTweenAlpha('E', 'camHUD.alpha', 1, 0.2, 'cubeOut');
        hover = true;
    elseif curStep == 1008 then
        playSound('SUPERBF', 1);
        setProperty('boyfriend.x', getProperty('boyfriend.x')-200);
        setProperty('boyfriend.y', getProperty('boyfriend.y')-200);
        bfSuper = true;
    elseif curStep == 256 then --dodgy stuff
        setProperty('dad.visible', false);
        setProperty('fleetwayAnims3.visible', true);
        if not botPlay then
            setProperty('dodgy.alpha', 1);
            objectPlayAnimation('dodgy', 'a', true);
        end
    elseif curStep == 264 then
        objectPlayAnimation('fleetwayAnims3', 'Laser Blas', true);
    end

    --reset to normal fleetway
    if curStep == 272 or curStep == 399 or curStep == 528 or curStep == 656 or curStep == 784 or curStep == 1040 or curStep == 1168 or curStep == 1296 or curStep == 1552 or curStep == 1680 or curStep == 1808 or curStep == 1952 then
        resetStuff();
        hover = true;
    end

    -- second extra fleetway anims
    if curStep == 1261 or curStep == 1543 or curStep == 1672 or curStep == 1792 or curStep == 1936 then
        setProperty('dad.visible', false);
        setProperty('fleetwayAnims2.visible', true);
        if curStep == 1261 then
            objectPlayAnimation('fleetwayAnims2', 'Show You', true);
        elseif curStep == 1543 then
            objectPlayAnimation('fleetwayAnims2', 'Scream', true);
        elseif curStep == 1672 then
            objectPlayAnimation('fleetwayAnims2', 'Growl', true);
        elseif curStep == 1792 then
            objectPlayAnimation('fleetwayAnims2', 'Shut Up', true);
        elseif curStep == 1936 then
            objectPlayAnimation('fleetwayAnims2', 'Right Alt', true);
        end
    end

    -- first extra fleetway anims
    if curStep == 383 or curStep == 512 or curStep == 640 or curStep == 776 or curStep == 1036 or curStep == 1152 then
        setProperty('dad.visible', false);
        setProperty('fleetwayAnims1.visible', true);
        if curStep == 383 then
            objectPlayAnimation('fleetwayAnims1', 'Step It Up', true);
        elseif curStep == 512 then
            objectPlayAnimation('fleetwayAnims1', 'Laugh', true);
        elseif curStep == 640 then
            objectPlayAnimation('fleetwayAnims1', 'Too Slow', true);
        elseif curStep == 776 then
            objectPlayAnimation('fleetwayAnims1', 'YoureFinished', true);
        elseif curStep == 1036 then
            objectPlayAnimation('fleetwayAnims1', 'WHAT?!', true);
        elseif curStep == 1152 then
            objectPlayAnimation('fleetwayAnims1', 'Grrr', true);
        end
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if mustHitSection then
        setProperty('camFollow.x', defaultCamPointX);
        setProperty('camFollow.y', defaultCamPointY);
        if direction == 0 then
            setProperty('camFollow.x', getProperty('camFollow.x')-45)
        elseif direction == 1 then
            setProperty('camFollow.y', getProperty('camFollow.y')+45)
        elseif direction == 2 then
            setProperty('camFollow.y', getProperty('camFollow.y')-45);
        elseif direction == 3 then
            setProperty('camFollow.x', getProperty('camFollow.x')+45);
        end
    end
end

function onGameOverConfirm()
    stopSound('joker');
end



function onSoundFinished(tag)
    if tag == 'joker' then
        soundFadeIn(nil, 0.3, 0.5, 1);
    end
end

function resetStuff()
    setProperty('fleetwayAnims1.visible', false);
    setProperty('fleetwayAnims2.visible', false);
    setProperty('fleetwayAnims3.visible', false);
    setProperty('dad.visible', true);
    setProperty('dodgy.visible', false);
end