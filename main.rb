def background args
  args.outputs.solids << [400,0,450,720,100,100,100]
end

def sidebar args

  args.outputs.solids << [0,0,400,720,0,0,0]
  args.outputs.solids << [800,0,880,720,0,0,0]

end

def points args
  @score ||= 0

  if @apple.inside_rect? @snake
    @score += 10
    args.state.ax += rand(500)
    args.state.ay += rand(600)
   end

end

def label args
  
  args.outputs.labels << [250,700,"Score:",255,255,255]
  args.outputs.labels << [315,700,@score,255,255,255]
  if args.state.start == 0
    args.outputs.labels << [475,700,"Press Enter to Start",255,55,255,]
  end
end

def apple args
  args.state.ax ||= 650
  args.state.ay ||= 100
  @apple = [args.state.ax,args.state.ay,15,15,255,1,1]
 
  args.outputs.solids << @apple

  if args.state.ax >= 775 
    args.state.ax = 401+rand(50)
  end
  if args.state.ay >= 675 
    args.state.ay = 1+rand(50)
  end
  if args.state.ax <= 400 
    args.state.ax = 750+rand(50)
  end
  if args.state.ay <= 0 
    args.state.ay = 700+rand(50)
  end
  
  
end

def snake args
  args.state.start ||= 0
  speed   = 1

  if args.inputs.keyboard.key_down.enter
    args.state.dx = speed
    args.state.dy = 0
    args.state.start = 1
  end
  args.state.x ||= 450  
 
    @snake = [args.state.x,
             args.state.y,
             args.state.ssx,
             args.state.ssy,
             1,
             255,
             1
    ]
                 
    if args.state.start == 1
      args.outputs.solids << @snake
    end
    
    #snake size
      args.state.ssx = 50 
      args.state.ssy = 50 
    
    #Snake Move
      args.state.x += args.state.dx
      args.state.y += args.state.dy
    #right
      if args.inputs.keyboard.key_down.right & args.state.dx == 0 
        args.state.dx = speed
        args.state.dy = 0
      end
    #up
      if args.inputs.keyboard.key_down.up & args.state.dy == 0 
        args.state.dx = 0
        args.state.dy = speed
      end
    #left
      if args.inputs.keyboard.key_down.left & args.state.dx == 0 
        args.state.dx = -speed
        args.state.dy = 0
      end
    #down
      if args.inputs.keyboard.key_down.down & args.state.dy == 0 
        args.state.dx = 0
        args.state.dy = -speed
      end

    #screen wrap  
      if args.state.x >= 801 
        args.state.x = 351
      end
      if args.state.y >= 720 
        args.state.y = -50
      end
      if args.state.x <= 350
        args.state.x = 800
      end
      if args.state.y <= -51 
        args.state.y = 720
      end
end

def tick args
  background args
  points args
  label args 
  apple args
  snake args
  sidebar args 
end
