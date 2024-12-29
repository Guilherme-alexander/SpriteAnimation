# SpriteAnimation Library for LOVE2D

**SpriteAnimation** is a library designed to simplify sprite animation management in games created using the LOVE2D framework. This library enables the creation, control, and rendering of animations based on sprite sheets with features like time control, animation looping, pausing and resuming animations, horizontal flipping, and speed adjustments.

## Features

The library offers the following features:

- **Animation creation**: Easily create animations from a sprite sheet based on position and size data.
- **Time control**: Controls frame switching based on time intervals.
- **Loop control**: Defines whether the animation should repeat or stop at the end.
- **Pause and resume**: Allows you to pause and resume the animation at any time.
- **Horizontal flip**: Enables flipping the animation horizontally (flipX).
- **Speed control**: Adjusts the animation speed by changing the time between frames.
- **Parameter validation**: Ensures that the parameters provided to create animations are valid.

## Installation

1. **Download the library**:
    - Download the `spriteAnimation.lua` file for your project.

2. **Add the library to your project**:
    - Place the `spriteAnimation.lua` file in your project folder or a subfolder such as `libs/`.

3. **Import the library** into your code:
    - To use the library, simply import the module in your `main.lua` file:

    ```lua
    local spriteAnimation = require "spriteAnimation"  -- or "libs.spriteAnimation" if placed in a subfolder
    ```

## Detailed Features

### 1. **Creating an Animation**

To create an animation, you need to provide:

- **spriteSheet**: The image containing the sprite sheet.
- **frameData**: A table with information about each frame (position and size).
- **frameTime**: The time each frame will be visible before moving to the next.

#### Example of Creating an Animation

```lua
local spriteAnimation = require "spriteAnimation"

-- Load the sprite sheet image
local spriteSheet = love.graphics.newImage("spritesheet.png")

-- Define data for each animation frame (position and size)
local frameData = {
    {x = 0, y = 0, width = 32, height = 32},  -- Frame 1
    {x = 32, y = 0, width = 32, height = 32}, -- Frame 2
    {x = 64, y = 0, width = 32, height = 32}, -- Frame 3
    {x = 96, y = 0, width = 32, height = 32}, -- Frame 4
}

-- Create the animation
local playerAnimation = spriteAnimation.new(spriteSheet, frameData, 0.1)
```

### 2. **Updating the Animation**

The `spriteAnimation.update` function is called every frame to update the animation state. You need to pass the animation object and the time delta `dt`.

#### Example of Updating the Animation

```lua
function love.update(dt)
    -- Update the player animation
    spriteAnimation.update(playerAnimation, dt)
end
```

### 3. **Drawing the Animation**

The `spriteAnimation.draw` function is responsible for drawing the current frame of the animation on the screen.

#### Example of Drawing the Animation

```lua
function love.draw()
    -- Draw the player with the animation
    spriteAnimation.draw(playerAnimation)
end
```

### 4. **Controlling the Animation Loop**

You can toggle between animations that loop or stop at the final frame. The `spriteAnimation.setLoop` function controls this behavior.

#### Example of Controlling Looping

```lua
-- Enable looping
spriteAnimation.setLoop(playerAnimation, true)

-- Disable looping (animation will not repeat)
spriteAnimation.setLoop(playerAnimation, false)
```

### 5. **Pausing and Resuming the Animation**

You can pause the animation and resume it later using the `spriteAnimation.pause` and `spriteAnimation.resume` functions.

#### Example of Pausing and Resuming the Animation

```lua
function love.keypressed(key)
    if key == "p" then
        -- Pause the animation
        spriteAnimation.pause(playerAnimation)
    elseif key == "r" then
        -- Resume the animation
        spriteAnimation.resume(playerAnimation)
    end
end
```

### 6. **Stopping the Animation**

If you want to stop the animation and reset to the first frame, you can use the `spriteAnimation.stop` function.

#### Example of Stopping the Animation

```lua
function love.keypressed(key)
    if key == "s" then
        -- Stop the animation and reset to the first frame
        spriteAnimation.stop(playerAnimation)
    end
end
```

### 7. **Changing the Animation Speed**

The `spriteAnimation.setSpeed` function allows you to increase or decrease the animation speed by changing the time between frames.

#### Example of Changing Speed

```lua
function love.keypressed(key)
    if key == "+" then
        -- Increase the animation speed (decrease the time between frames)
        spriteAnimation.setSpeed(playerAnimation, 1.5)
    elseif key == "-" then
        -- Decrease the animation speed (increase the time between frames)
        spriteAnimation.setSpeed(playerAnimation, 0.5)
    end
end
```

### 8. **Horizontal Flipping (FlipX)**

You can flip the animation horizontally with the `spriteAnimation.flip` function. This is useful for animations where the character can face left or right.

#### Example of Flipping the Animation

```lua
function love.keypressed(key)
    if key == "f" then
        -- Toggle the horizontal flip
        spriteAnimation.flip(playerAnimation, not playerAnimation.flipX)
    end
end
```

### 9. **Parameter Validation**

The library performs some validation to ensure that the parameters provided are valid, which helps avoid common errors when creating animations, such as missing a `spriteSheet` or invalid `frameData`.

### 10. **Controlling Position**

You can move the animations on the screen by adjusting the `x` and `y` values of the animation object. This allows you to draw the animation anywhere on the screen.

#### Example of Controlling Position

```lua
function love.update(dt)
    -- Move the animation
    playerAnimation.x = playerAnimation.x + 1
    playerAnimation.y = playerAnimation.y + 1

    -- Update the animation
    spriteAnimation.update(playerAnimation, dt)
end
```

## Complete Example

Here is a complete example showing how to create an animation and control it with keyboard input:

```lua
local spriteAnimation = require "spriteAnimation"

local playerAnimation

function love.load()
    -- Load the sprite sheet
    local spriteSheet = love.graphics.newImage("spritesheet.png")

    -- Frame data for the animation
    local frameData = {
        {x = 0, y = 0, width = 32, height = 32},
        {x = 32, y = 0, width = 32, height = 32},
        {x = 64, y = 0, width = 32, height = 32},
        {x = 96, y = 0, width = 32, height = 32},
    }

    -- Create the animation
    playerAnimation = spriteAnimation.new(spriteSheet, frameData, 0.1)

    -- Set initial position
    playerAnimation.x = 100
    playerAnimation.y = 100
end

function love.update(dt)
    -- Update the animation
    spriteAnimation.update(playerAnimation, dt)
end

function love.draw()
    -- Draw the player animation
    spriteAnimation.draw(playerAnimation)
end

function love.keypressed(key)
    if key == "p" then
        -- Pause the animation
        spriteAnimation.pause(playerAnimation)
    elseif key == "r" then
        -- Resume the animation
        spriteAnimation.resume(playerAnimation)
    elseif key == "s" then
        -- Stop and reset the animation
        spriteAnimation.stop(playerAnimation)
    elseif key == "f" then
        -- Toggle horizontal flip
        spriteAnimation.flip(playerAnimation, not playerAnimation.flipX)
    elseif key == "+" then
        -- Increase animation speed
        spriteAnimation.setSpeed(playerAnimation, 1.5)
    elseif key == "-" then
        -- Decrease animation speed
        spriteAnimation.setSpeed(playerAnimation, 0.5)
    end
end
```

---

## Contributing

If you'd like to contribute to the library, feel free to open an *issue* or submit a *pull request*. All contributions are welcome!

---

### License

The **SpriteAnimation** library is licensed under the [MIT License](https://opensource.org/licenses/MIT). Feel free to use, modify, and distribute this library, as long as you provide appropriate credit.
