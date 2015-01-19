# placeholder coffee component creation taken from https://github.com/starwed/Bounds
# # An animated effect that runs once and is destroyed
# Crafty.c("AnimatedEffect", {
#     init: ()-> 
#         this.requires("2D, Canvas, Sprite, SpriteAnimation, Tween")

#     setAnimation: (reelId, frames)->
#         @reelName = reelId
#         @animate(reelId, frames)
#         return this


#     setTween: (properties)-> 
#         @tweenProp = properties
#         return this

#     runAnimation: (duration)->
#         onAnimationEnd = ()=> 
#             @destroy()
#         if @reelName
#             @bind("AnimationEnd", onAnimationEnd)
#             @playAnimation(@reelName, duration)
#         if @tweenProp
#             @bind("TweenEnd", onAnimationEnd)
#             @tween(@tweenProp, duration)
#         return this

# })

# Crafty.c "MapTile",
#     init: ()-> @
#     setMapInfo: (@map_c, @map_r, @tiledLevel, @mapTileType)-> @
#     findRelativeTile: (a, b)->
#         if typeof a is "string"
#             [dr, dc] = switch a
#                 when "above" then [-1, 0]
#                 when "below" then [1, 0] 
#                 when "right" then [0, 1] 
#                 when "left" then  [0, -1] 
#         else
#             [dr, dc] = [a, b]
#         @tiledLevel.getTile(@map_r+dr, @map_c+dc)