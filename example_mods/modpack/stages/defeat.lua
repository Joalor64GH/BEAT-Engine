function onCreate() --create the background
    makeLuaSprite('bg', 'defeatfnf', 120, 150)
    addLuaSprite('bg', false)
    setProperty('bg.alpha', 0)
end

function onCreatePost()--adjust stuff
    setProperty('gf.alpha', 0)
    setProperty('dad.alpha', 0)
    setProperty('boyfriend.alpha', 0)

    setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'loss-defeat')
    setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'amongUsGameOver')
    setPropertyFromClass('GameOverSubstate', 'endSoundName', 'amongUsGameOverEnd')
    setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-die')
end