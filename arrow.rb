require 'io/console'

class SnakeGame
  def initialize(width, height)
    @width = width
    @height = height
    @snake = [[width / 2, height / 2]]
    @food = []
    @game_over = false
    @direction = :right
    generate_food
  end

  def start
    loop do
      draw
      input = STDIN.getch
      case input
      when 'q'
        exit
      when 'u'
        @direction = :up
      when 'l'
        @direction = :left
      when 'd'
        @direction = :down
      when 'r'
        @direction = :right
      end
      move
      break if @game_over
    end
    puts "Made By himanshu"
    puts "Game over!"
    puts "Score: #{@snake.length}"
  end

  private

  def generate_food
    loop do
      x = rand(@width)
      y = rand(@height)
      unless @snake.include?([x, y]) or @food.include?([x, y])
        @food = [[x, y]]
        break
      end
    end
  end

  def move
    head = @snake.last.dup
    case @direction
    when :up
      head[1] -= 1
    when :left
      head[0] -= 1
    when :down
      head[1] += 1
    when :right
      head[0] += 1
    end
    if @snake.include?(head) or head[0] < 0 or head[0] >= @width or head[1] < 0 or head[1] >= @height
      @game_over = true
    else
      @snake << head
      if head == @food.first
        generate_food
      else
        @snake.shift
      end
    end
  end

  def draw
    system('clear')
    puts "Score: #{@snake.length}"
    puts "+" + "-" * @width + "+"
    @height.times do |y|
      print "|"
      @width.times do |x|
        if @snake.include?([x, y])
          print "→"
        elsif @food.include?([x, y])
          print "*"
        else
          print " "
        end
      end
      puts "|"
    end
    puts "+" + "-" * @width + "+"
  end
end

game = SnakeGame.new(250, 150)
game.start


