-- https://github.com/guilherme-alexander

local spriteAnimation = {}

-- Função para criar uma nova animação
-- spriteSheet: a imagem contendo os quadros de animação
-- frameData: uma tabela contendo as posições e tamanhos dos quadros
-- frameTime: tempo entre cada quadro (em segundos)

function spriteAnimation.new(spriteSheet, frameData, frameTime)
    -- Validação do spriteSheet
    if not spriteSheet or not spriteSheet.getDimensions then
        error("spriteSheet deve ser uma imagem válida.")
    end

    -- Validação de frameData
    if type(frameData) ~= "table" or #frameData == 0 then
        error("frameData deve ser uma tabela com ao menos um quadro.")
    end

    local animation = {
        spriteSheet = spriteSheet,
        quads = {},
        currentFrame = 1,
        frameTime = frameTime or 0.1,
        elapsedTime = 0,
        x = 0, -- Posição X na tela (inicialmente 0)
        y = 0, -- Posição Y na tela (inicialmente 0)
        isPaused = false, -- Estado de pausa da animação
        flipX = false, -- Controle de flip horizontal
        loop = true, -- Controle de loop da animação
    }

    -- Criar os quadros para a animação com base nas posições e tamanhos passados
    for _, frame in ipairs(frameData) do
        local x = frame.x
        local y = frame.y
        local frameWidth = frame.width
        local frameHeight = frame.height
        
        -- Verificar se frameWidth e frameHeight são números válidos
        if type(frameWidth) == "number" and type(frameHeight) == "number" then
            table.insert(animation.quads, love.graphics.newQuad(x, y, frameWidth, frameHeight, spriteSheet:getDimensions()))
        else
            error("frameWidth e frameHeight devem ser números válidos.")
        end
    end

    return animation
end

-- Função para atualizar o tempo de animação
function spriteAnimation.update(animation, dt)
    if animation.isPaused then
        return
    end

    animation.elapsedTime = animation.elapsedTime + dt

    if animation.elapsedTime >= animation.frameTime then
        animation.currentFrame = animation.currentFrame + 1
        if animation.currentFrame > #animation.quads then
            if animation.loop then
                animation.currentFrame = 1 -- Reinicia a animação se estiver em loop
            else
                animation.currentFrame = #animation.quads -- Se não estiver em loop, mantemos no último quadro
            end
        end
        animation.elapsedTime = animation.elapsedTime - animation.frameTime
    end
end

-- Função para desenhar o quadro atual
function spriteAnimation.draw(animation)
    local scaleX = animation.flipX and -1 or 1
    love.graphics.draw(animation.spriteSheet, animation.quads[animation.currentFrame], animation.x, animation.y, 0, scaleX, 1)
end

-- Função para pausar a animação
function spriteAnimation.pause(animation)
    animation.isPaused = true
end

-- Função para retomar a animação
function spriteAnimation.resume(animation)
    animation.isPaused = false
end

-- Função para parar a animação
function spriteAnimation.stop(animation)
    animation.isPaused = true
    animation.currentFrame = 1 -- Reinicia a animação para o primeiro quadro
end

-- Função para mudar a velocidade da animação
function spriteAnimation.setSpeed(animation, speedFactor)
    animation.frameTime = animation.frameTime * speedFactor
end

-- Função para ativar ou desativar o loop da animação
function spriteAnimation.setLoop(animation, loop)
    animation.loop = loop
end

-- Função para inverter a animação horizontalmente (flip)
function spriteAnimation.flip(animation, flipX)
    animation.flipX = flipX
end

return spriteAnimation
