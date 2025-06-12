
loadstring(game:HttpGet("https://your-vercel-domain.vercel.app/XeraLoader.lua"))():Start({
    Title = "XeraUltron",
    SubTitle = "Meta Solution",
    Stages = {
        "Initializing...",
        "Connecting to MetaNet...",
        "Loading Visual Core...",
        "Applying Optimizations...",
        "Starting XeraHub..."
    },
    Sound = true,
    OnFinish = function()
        print("✅ XeraUltron Ready!")
    end
})
