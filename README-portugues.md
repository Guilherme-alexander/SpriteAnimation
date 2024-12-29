# SpriteAnimation Library for LOVE2D

A **SpriteAnimation** é uma biblioteca desenvolvida para facilitar o gerenciamento e a animação de sprites em jogos criados com o framework LOVE2D. Esta biblioteca permite a criação, controle e renderização de animações baseadas em uma folha de sprites (sprite sheet), com recursos como controle de tempo, loop de animação, flip horizontal e ajustes de velocidade.

## Funcionalidades

A biblioteca oferece as seguintes funcionalidades:

- **Criação de animação**: Facilita a criação de animações a partir de uma folha de sprites com base em dados de posição e tamanho.
- **Controle de tempo**: Controla a troca de quadros com base no tempo.
- **Controle de loop**: Define se a animação será repetida ou parada ao atingir o final.
- **Pausar e retomar animação**: Permite parar ou retomar a animação a qualquer momento.
- **Inversão horizontal (flip)**: Habilita a inversão horizontal da animação (flipX).
- **Controle de velocidade**: Altera a velocidade da animação, aumentando ou diminuindo o tempo entre quadros.
- **Validação de parâmetros**: Garante que os parâmetros fornecidos para criar animações sejam válidos.

## Instalação

1. **Baixe o arquivo da biblioteca**:
    - Faça o download do arquivo `spriteAnimation.lua` para o seu projeto LOVE2D.

2. **Adicione a biblioteca ao seu projeto**:
    - Coloque o arquivo `spriteAnimation.lua` na pasta do seu projeto ou em uma subpasta como `libs/`.

3. **Importe a biblioteca** no seu código:
    - Para utilizar a biblioteca, basta importar o módulo no arquivo `main.lua`:

    ```lua
    local spriteAnimation = require "spriteAnimation"  -- ou "libs.spriteAnimation" se estiver em uma subpasta
    ```

## Funcionalidades Detalhadas

### 1. **Criação de Animação**

Para criar uma animação, você precisa fornecer:

- **spriteSheet**: A imagem que contém a folha de sprites.
- **frameData**: Uma tabela com informações sobre cada quadro (posição e tamanho).
- **frameTime**: O tempo que cada quadro ficará visível antes de mudar para o próximo.

#### Exemplo de Criação de Animação

```lua
local spriteAnimation = require "spriteAnimation"

-- Carregar a imagem da folha de sprites
local spriteSheet = love.graphics.newImage("spritesheet.png")

-- Definir dados de cada quadro da animação (posição e tamanho)
local frameData = {
    {x = 0, y = 0, width = 32, height = 32},  -- Quadro 1
    {x = 32, y = 0, width = 32, height = 32}, -- Quadro 2
    {x = 64, y = 0, width = 32, height = 32}, -- Quadro 3
    {x = 96, y = 0, width = 32, height = 32}, -- Quadro 4
}

-- Criar animação
local playerAnimation = spriteAnimation.new(spriteSheet, frameData, 0.1)
```

### 2. **Atualização de Animação**

A função `spriteAnimation.update` é chamada a cada quadro para atualizar o estado da animação. Você precisa passar o objeto da animação e o tempo `dt` (tempo entre atualizações).

#### Exemplo de Atualização

```lua
function love.update(dt)
    -- Atualiza a animação do jogador
    spriteAnimation.update(playerAnimation, dt)
end
```

### 3. **Desenhar Animação**

A função `spriteAnimation.draw` é responsável por desenhar o quadro atual da animação na tela.

#### Exemplo de Desenho

```lua
function love.draw()
    -- Desenhar o jogador com a animação
    spriteAnimation.draw(playerAnimation)
end
```

### 4. **Controle de Loop da Animação**

Você pode alternar entre animações que são repetidas (loop) ou que param ao atingir o último quadro. A função `spriteAnimation.setLoop` controla isso.

#### Exemplo de Controle de Loop

```lua
-- Ativar loop
spriteAnimation.setLoop(playerAnimation, true)

-- Desativar loop (animação não se repete)
spriteAnimation.setLoop(playerAnimation, false)
```

### 5. **Pausar e Retomar Animação**

Você pode pausar a animação e retomar posteriormente com as funções `spriteAnimation.pause` e `spriteAnimation.resume`.

#### Exemplo de Pausar e Retomar

```lua
function love.keypressed(key)
    if key == "p" then
        -- Pausar animação
        spriteAnimation.pause(playerAnimation)
    elseif key == "r" then
        -- Retomar animação
        spriteAnimation.resume(playerAnimation)
    end
end
```

### 6. **Parar a Animação**

Se você quiser parar a animação e reiniciar no primeiro quadro, pode usar a função `spriteAnimation.stop`.

#### Exemplo de Parar a Animação

```lua
function love.keypressed(key)
    if key == "s" then
        -- Parar animação e reiniciar no primeiro quadro
        spriteAnimation.stop(playerAnimation)
    end
end
```

### 7. **Alterar Velocidade da Animação**

A função `spriteAnimation.setSpeed` permite aumentar ou diminuir a velocidade da animação, alterando o tempo entre os quadros.

#### Exemplo de Alterar Velocidade

```lua
function love.keypressed(key)
    if key == "+" then
        -- Aumenta a velocidade da animação (diminui o tempo entre os quadros)
        spriteAnimation.setSpeed(playerAnimation, 1.5)
    elseif key == "-" then
        -- Diminui a velocidade da animação (aumenta o tempo entre os quadros)
        spriteAnimation.setSpeed(playerAnimation, 0.5)
    end
end
```

### 8. **Inverter Horizontalmente (Flip)**

Você pode inverter horizontalmente a animação (flipX) com a função `spriteAnimation.flip`. Isso é útil para animações de personagens que podem olhar para a esquerda ou para a direita.

#### Exemplo de Flip Horizontal

```lua
function love.keypressed(key)
    if key == "f" then
        -- Alternar entre flip horizontal e normal
        spriteAnimation.flip(playerAnimation, not playerAnimation.flipX)
    end
end
```

### 9. **Validação de Parâmetros**

A biblioteca realiza algumas validações para garantir que os parâmetros fornecidos sejam válidos. Isso ajuda a evitar erros comuns ao criar animações, como não fornecer um `spriteSheet` ou `frameData` inválido.

### 10. **Controle de Posição**

As animações podem ser movidas pela tela ajustando as variáveis `x` e `y` do objeto da animação. Isso permite que você desenhe a animação em qualquer posição da tela.

#### Exemplo de Controle de Posição

```lua
function love.update(dt)
    -- Mover a animação
    playerAnimation.x = playerAnimation.x + 1
    playerAnimation.y = playerAnimation.y + 1

    -- Atualizar animação
    spriteAnimation.update(playerAnimation, dt)
end
```

## Exemplo Completo

Aqui está um exemplo completo de como usar a biblioteca para criar uma animação e controlá-la com as teclas:

```lua
local spriteAnimation = require "spriteAnimation"

local playerAnimation

function love.load()
    -- Carregar o sprite sheet
    local spriteSheet = love.graphics.newImage("spritesheet.png")

    -- Dados dos quadros da animação
    local frameData = {
        {x = 0, y = 0, width = 32, height = 32},
        {x = 32, y = 0, width = 32, height = 32},
        {x = 64, y = 0, width = 32, height = 32},
        {x = 96, y = 0, width = 32, height = 32},
    }

    -- Criar a animação
    playerAnimation = spriteAnimation.new(spriteSheet, frameData, 0.1)

    -- Posição inicial
    playerAnimation.x = 100
    playerAnimation.y = 100
end

function love.update(dt)
    -- Atualizar a animação
    spriteAnimation.update(playerAnimation, dt)
end

function love.draw()
    -- Desenhar a animação do jogador
    spriteAnimation.draw(playerAnimation)
end

function love.keypressed(key)
    if key == "p" then
        -- Pausar a animação
        spriteAnimation.pause(playerAnimation)
    elseif key == "r" then
        -- Retomar a animação
        spriteAnimation.resume(playerAnimation)
    elseif key == "s" then
        -- Parar e reiniciar a animação
        spriteAnimation.stop(playerAnimation)
    elseif key == "f" then
        -- Alternar o flip horizontal
        spriteAnimation.flip(playerAnimation, not playerAnimation.flipX)
    elseif key == "+" then
        -- Aumentar a velocidade da animação
        spriteAnimation.setSpeed(playerAnimation, 1.5)
    elseif key == "-" then
        -- Diminuir a velocidade da animação
        spriteAnimation.setSpeed(playerAnimation, 0.5)
    end
end
```

---

## Contribuições

Se você gostaria de contribuir para a biblioteca, sinta-se à vontade para abrir uma *issue* ou enviar um *pull request*. Toda contribuição é bem-vinda!

---

### Licença

A biblioteca **SpriteAnimation** é licenciada sob a [MIT License](https://opensource.org/licenses/MIT). Sinta-se livre para usar, modificar e distribuir esta biblioteca, desde que mantenha a atribuição devida.
