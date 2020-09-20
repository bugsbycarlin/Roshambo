
var context;

var mode = "title";
var sub_mode = "";

var robot_images = []
robot_images["normal"] = new Image()
robot_images["normal"].src = "Art/robot_normal.png"
robot_images["shooting"] = new Image()
robot_images["shooting"].src = "Art/robot_shooting.png"
robot_images["hurt"] = new Image()
robot_images["hurt"].src = "Art/robot_hurt.png"
robot_images["dying"] = new Image()
robot_images["dying"].src = "Art/robot_dying.png"
robot_images["dying_2"] = new Image()
robot_images["dying_2"].src = "Art/robot_dying_2.png"

var title_screen = new Image();
title_screen.src = "Art/title_screen.png";

var one_player_button = new Image();
one_player_button.src = "Art/one_player_button.png";

var two_player_button = new Image();
two_player_button.src = "Art/two_player_button.png";

var background = new Image();
background.src = "Art/background.png";

var what_is_love = new Image();
what_is_love.src = "Art/what_is_love.png";

var dont_hurt_me = new Image();
dont_hurt_me.src = "Art/dont_hurt_me.png";

var round_text = new Image();
round_text.src = "Art/round.png";

var rock = new Image();
rock.src = "Art/rock.png";

var paper = new Image();
paper.src = "Art/paper.png";

var scissors = new Image();
scissors.src = "Art/scissors.png";

var explosion_sprite = new Image();
explosion_sprite.src = "Art/explosion.png";

var music_off = new Image();
music_off.src = "Art/music_off.png";

var music_on = new Image();
music_on.src = "Art/music_on.png";

var health_bar = new Image();
health_bar.src = "Art/health_bar.png";

var health_bar_fill = new Image();
health_bar_fill.src = "Art/health_bar_fill.png";

var game_over_text = new Image();
game_over_text.src = "Art/game_over.png";

var press_space_text = new Image();
press_space_text.src = "Art/press_space.png";

var h1 = new Image();
h1.src = "Art/h1.png";
var h2 = new Image();
h2.src = "Art/h2.png";
var h3 = new Image();
h3.src = "Art/h3.png";
var h4 = new Image();
h4.src = "Art/h4.png";

var lightning_1 = new Image();
lightning_1.src = "Art/lightning_1.png";
var lightning_2 = new Image();
lightning_2.src = "Art/lightning_2.png";

music = true;

bullet_types = [rock, paper, scissors];

var number_text = [];
for (var i = 0; i < 10; i++) {
  number_text[i] = new Image();
  number_text[i].src = "Art/" + i + ".png";
}

round = 1;
start_time = 0;

speed_lines = [];
max_speed_lines = 400;

left_bot = new Object();
right_bot = new Object();

explosions = [];

player_1_choice = rock;
player_2_choice = rock;
player_1_pressed = false;
player_2_pressed = false;

player_1_score = 0;
player_2_score = 0;
player_1_display_score = 0;
player_2_display_score = 0;

players = 1;


function initialize()
{
  $('img').bind('dragstart', function(event) { event.preventDefault(); });
  
  canvas = document.getElementById('canvas');

  document.addEventListener("keydown", handleKeydown, false);
  document.addEventListener("keyup", handleKeyup, false);
  
  canvas.width = 1080;
  canvas.height = 450;

  canvas.style.visibility = 'visible';
  var loadingdiv = document.getElementById('loadingdiv');
  loadingdiv.style.visibility = 'hidden';

  setInterval(update,36);

  context = canvas.getContext('2d');

  mode = "title";
}

function draw(image, x, y, flip, angle) {
  context.save();
  context.translate(x, y);
  context.rotate((Math.PI / 180) * angle);
  if (flip === true) {
    context.scale(-1, 1);
  }
  context.drawImage(image, -1 * image.width / 2, -1 * image.height / 2);
  context.restore();
}

function drawFromTopLeft(image, x, y, x_scale) {
  context.save();
  context.translate(x, y);
  if (x_scale != undefined) {
    context.scale(x_scale, 1);
  }
  context.drawImage(image, 0, 0);
  context.restore();
}

function initGame(num_players) {
  player_1_score = 0;
  player_2_score = 0;
  player_1_display_score = 0;
  player_2_display_score = 0;
  round = 1;
  players = num_players;
  initRound();
  djStartTheDance();
  
  if (h_enabled === false) {
    h_enabled = true;
    setTimeout( function() {
      setInterval(flash_of_h,439);
    }, 14632); // not 15071, gotta go one interval early
  }
}

function initRound() {
  speed_lines = [];
  for (var i = 0; i < 30; i++) {
    addSpeedLine();
  }

  left_bot = new Object();
  left_bot.x = 80;
  left_bot.y = -150;
  left_bot.angle = 0;
  left_bot.x_vel = 0;
  left_bot.y_vel = 0;
  left_bot.health = 1000;
  left_bot.state = "descending";
  left_bot.frame = "normal";
  left_bot.bullets = [];

  right_bot = new Object();
  right_bot.x = 1080 - 80;
  right_bot.y = -150;
  right_bot.angle = 0;
  right_bot.x_vel = 0;
  right_bot.y_vel = 0;
  right_bot.health = 1000;
  right_bot.state = "descending";
  right_bot.frame = "normal";
  right_bot.bullets = [];

  player_1_choice = bullet_types[getRandomInt(3)];
  player_2_choice = bullet_types[getRandomInt(3)];

  explosions = [];

  mode = "game"
  sub_mode = "intro_1";
  start_time = (new Date()).getTime();
}

function djStartTheDance() {
  // var volume = 0.4;
  // $("#song_1").prop("volume",volume);
  // $("#song_2").prop("volume",volume);
  // $("#song_3").prop("volume",volume);
  // $("#song_4").prop("volume", volume);
  
  $("#watiz").bind("ended", function(){
    $("#watiz").trigger("play");
  });
  $("#watiz").trigger("play");
}

h_images = [h1, h2, h3, h4];
lightning_images = [lightning_2, lightning_1, lightning_2, lightning_1];
h_value = -1;
h_count = 0;
h_enabled = false;
function flash_of_h() {
  h_value += 1
  h_count = 8;
}

function update() {
  if (mode === "title") {
    //pass
  } else if (mode === "game") {
    updateGame();
  }

  render();
}

function updateGame() {
  h_count = h_count - 1;
  if (h_count === 0) {
    h_count = 0;
  }

  time_since = (new Date()).getTime() - start_time;
  if (sub_mode == "intro_1") {
    if(speed_lines.length < max_speed_lines) {
      for (var i = 0; i < 10; i++) {
        addSpeedLine();
      }
    }
    updateSpeedLines();

    if (time_since > 900) {
      sub_mode = "intro_2";
    }
  }

  if (sub_mode == "intro_2") {
    updateSpeedLines();

    if (time_since > 3000) {
      deleteSpeedLines();
      sub_mode = "intro_3";
    }
  }

  ready = true;

  if (left_bot.state == "descending" && left_bot.y < 260) {
    left_bot.y = left_bot.y + 4;
    ready = false;
  } 

  if (right_bot.state == "descending" && right_bot.y < 260) {
    right_bot.y = right_bot.y + 4;
    ready = false;
  }

  if (sub_mode == "intro_3" && ready) {
    sub_mode = "active";
    left_bot.state = "normal";
    right_bot.state = "normal";
    left_bot.float_time = (new Date()).getTime();
    right_bot.float_time = (new Date()).getTime();
    left_bot.counter = 0;
    right_bot.counter = 0;
  }


  if (sub_mode === "active" || sub_mode === "dying" || sub_mode === "game_over") {
    for (var i = 0; i < right_bot.bullets.length; i++) {
      bullet = right_bot.bullets[i];
      bullet.x += bullet.x_vel;
    }

    for (var i = 0; i < left_bot.bullets.length; i++) {
      bullet = left_bot.bullets[i];
      bullet.x += bullet.x_vel;
    }
  }

  if (sub_mode === "active") {
    left_bot.y = 260 + 20 * Math.sin(2 * Math.PI * ((new Date()).getTime() - left_bot.float_time) / 1720);
    right_bot.y = 260 + 20 * Math.sin(2 * Math.PI * ((new Date()).getTime() - right_bot.float_time) / 1720);

    left_bot.counter += 1;
    right_bot.counter += 1;

    if (players === 1) {
      if (round < 6) {
        if (left_bot.health < 1000) left_bot.health += 1;
      }
      if (round > 4) {
        if (right_bot.health < 1000) right_bot.health += 1;
      }
    }

    var new_right_bullets = [];
    for (var i = 0; i < right_bot.bullets.length; i++) {
      bullet = right_bot.bullets[i];

      for (var j = 0; j < left_bot.bullets.length; j++) {
        bullet_2 = left_bot.bullets[j];
        if (bullet.x < bullet_2.x) { // collision!
          if ((bullet.type === rock && bullet_2.type === rock) ||
              (bullet.type === paper && bullet_2.type === paper) ||
              (bullet.type === scissors && bullet_2.type === scissors)) {
            bullet.health = 0;
            bullet_2.health = 0;
          } else if ((bullet.type === rock && bullet_2.type === scissors) ||
              (bullet.type === paper && bullet_2.type === rock) ||
              (bullet.type === scissors && bullet_2.type === paper)) {
            bullet.health -= 1;
            bullet_2.health = 0;
          } else if ((bullet.type === rock && bullet_2.type === paper) ||
              (bullet.type === paper && bullet_2.type === scissors) ||
              (bullet.type === scissors && bullet_2.type === rock)) {
            bullet.health = 0;
            bullet_2.health -= 1;
          }
          explosion = new Object();
          explosion.x = (bullet.x + bullet_2.x) / 2.0;
          explosion.y = (bullet.y + bullet_2.y) / 2.0;
          explosion.counter = 2;
          explosions.push(explosion)
        }
      }

      if (bullet.x < left_bot.x + 30) {
        // collision with player!
        bullet.health = 0
        left_bot.health -= 50;
        if (left_bot.health < 0) left_bot.health = 0;
        left_bot.frame = "hurt"
        left_bot.hurt_counter = 2;
        if (players === 1) {
          player_2_score += 50;
        }
        explosion = new Object();
        explosion.x = bullet.x
        explosion.y = bullet.y
        explosion.counter = 2;
        explosions.push(explosion)
      }

      if (bullet.health > 0 && bullet.x > -40) {
        new_right_bullets.push(bullet);
      }
    }
    right_bot.bullets = new_right_bullets;

    var new_left_bullets = [];
    for (var i = 0; i < left_bot.bullets.length; i++) {
      bullet = left_bot.bullets[i];
      
      if (bullet.x > right_bot.x - 30) {
        // collision with player!
        bullet.health = 0
        right_bot.health -= 50;
        if (right_bot.health < 0) right_bot.health = 0;
        right_bot.frame = "hurt"
        right_bot.hurt_counter = 2;
        if (players === 1) {
          player_1_score += 50;
        }
        explosion = new Object();
        explosion.x = bullet.x
        explosion.y = bullet.y
        explosion.counter = 2;
        explosions.push(explosion)
      }

      if (bullet.health > 0 && bullet.x < 1120) {
        new_left_bullets.push(bullet);
      }
    }
    left_bot.bullets = new_left_bullets;

    if (players === 1) {
      player_2_pressed = true;
      round_step = 3 * Math.max(1, 10 - round)
      if (right_bot.counter % round_step === 0) {
        player_2_choice = bullet_types[getRandomInt(3)];
      }
    }

    if (right_bot.state === "normal") {
      if (right_bot.counter % 3 == 1 && player_2_pressed === true) {
        right_bot.frame = "shooting";
        bullet = new Object();
        bullet.x = right_bot.x - 64;
        bullet.y = right_bot.y - 13;
        bullet.x_vel = -23;
        bullet.type = player_2_choice;
        bullet.health = 2 + getRandomInt(2);
        right_bot.bullets.push(bullet);
      } else if (left_bot.frame === "shooting") {
        left_bot.frame = "normal";
      } else if (left_bot.frame === "hurt") {
        left_bot.hurt_counter -= 1;
        if (left_bot.hurt_counter === 0) {
          left_bot.frame = "normal";
        }
      }
    }

    if (left_bot.state === "normal") {
      if(left_bot.counter % 3 == 1 && player_1_pressed === true) {
        left_bot.frame = "shooting";
        bullet = new Object();
        bullet.x = left_bot.x + 64;
        bullet.y = left_bot.y - 13;
        bullet.x_vel = 23;
        bullet.type = player_1_choice;
        bullet.health = 2 + getRandomInt(2);
        left_bot.bullets.push(bullet);
      } else if (left_bot.frame === "shooting") {
        left_bot.frame = "normal";
      } else if (left_bot.frame === "hurt") {
        left_bot.hurt_counter -= 1;
        if (left_bot.hurt_counter === 0) {
          left_bot.frame = "normal";
        }
      }
    }

    if (left_bot.health <= 0 || right_bot.health <= 0) {
      player_1_pressed = false;
      player_2_pressed = false;
      sub_mode = "dying";
      if (left_bot.health <= 0) {
        left_bot.state = "dying";
        left_bot.frame = "dying";
        left_bot.x_vel = -12;
        left_bot.y_vel = -4;
      }
      if (right_bot.health <= 0) {
        right_bot.state = "dying";
        right_bot.frame = "dying";
        right_bot.x_vel = 12;
        right_bot.y_vel = -4;
      }
    }
  }

  if (sub_mode === "active" || sub_mode === "dying" || sub_mode === "game_over") {
    var new_explosions = [];
    for (var i = 0; i < explosions.length; i++) {
      explosion = explosions[i];
      explosion.counter -= 1;

      if (explosion.counter > 0) {
        new_explosions.push(explosion);
      }
    }
    explosions = new_explosions;
  }

  if (sub_mode === "dying") {
    player_1_pressed = false;
    player_2_pressed = false;
    if (left_bot.state == "dying") {
      left_bot.x += left_bot.x_vel;
      left_bot.x_vel *= 0.9;
      left_bot.y += left_bot.y_vel;
      left_bot.y_vel += 2;
      left_bot.angle -= 3;
      if (left_bot.frame === "dying") {
        left_bot.frame = "dying_2";
      } else {
        left_bot.frame = "dying";
      }
    } else {
      left_bot.frame = "normal";
      left_bot.y = 260 + 20 * Math.sin(2 * Math.PI * ((new Date()).getTime() - left_bot.float_time) / 1720);
    }
    if (right_bot.state == "dying") {
      right_bot.x += right_bot.x_vel;
      right_bot.x_vel *= 0.9;
      right_bot.y += right_bot.y_vel;
      right_bot.y_vel += 2;
      right_bot.angle += 3;
      if (right_bot.frame === "dying") {
        right_bot.frame = "dying_2";
      } else {
        right_bot.frame = "dying";
      }
    } else {
      right_bot.frame = "normal";
      right_bot.y = 260 + 20 * Math.sin(2 * Math.PI * ((new Date()).getTime() - right_bot.float_time) / 1720);
    }

    if (left_bot.y > 550 || right_bot.y > 550) {
      player_1_pressed = false;
      player_2_pressed = false;
      if (players === 1 && left_bot.health <= 0) {
        sub_mode = "game_over";

      } else if (players === 1) {
        round += 1;
        initRound();
      } else if (players === 2) {
        if (left_bot.health <= 0) {
          player_2_score += 1
        }
        if (right_bot.health <= 0) {
          player_1_score += 1
        }
        round += 1;
        initRound();
      }
    }
  }
}

// from 0 to one less than max; calling with 3 gives 0, 1, 2
function getRandomInt(max) {
  return Math.floor(Math.random() * Math.floor(max));
}

function dec2hex(dec) {
    return Number(parseInt( dec , 10)).toString(16);
}

function addSpeedLine() {
  line = new Object();
  line.height = 10 + getRandomInt(20);
  line.width = 300 + getRandomInt(400);
  line.x = 1090 + getRandomInt(100);
  line.y = getRandomInt(450);
  color_percent = Math.random();

  line.color = "#" + 
      dec2hex(Math.floor(32 + color_percent * 40)) +
      dec2hex(Math.floor(42 + color_percent * 100)) +
      dec2hex(Math.floor(44 + color_percent * 160));

  line.x_vel = 95 + getRandomInt(185);

  speed_lines.push(line)
}

function updateSpeedLines() {
  new_speed_lines = [];
  for (var i = 1; i < speed_lines.length; i++) {
    line = speed_lines[i];
    line.x -= line.x_vel;
    if (line.x + line.width > 0) {
      new_speed_lines.push(line)
    }
  }
  speed_lines = new_speed_lines;
}

function deleteSpeedLines() {
  speed_lines = [];
}

function render() {
  // clear the screen
  context.fillStyle = "#000000";
  context.fillRect(0,0,canvas.width,canvas.height);

  if (mode === "title") {
    renderTitle(context);
  } else {
    renderGame(context);
  }

  if (music) {
    draw(music_on, 40, 430);
  } else {
    draw(music_off, 40, 430);
  }
}

function drawNumber(number, x, y) {
  if (number > 0) {
    var display_number = number;
    var digits = Math.floor(Math.log10(number));
    for (var i = digits; i >= 0; i--) {
      var current_digit = Math.floor(display_number / (Math.pow(10, i)));
      display_number -= Math.pow(10, i) * current_digit;
      context.drawImage(number_text[current_digit], x + 26 * (digits - i), y); 
    }
    return digits;
  } else if (number === 0) {
    context.drawImage(number_text[0], x, y);
    return 0;
  }
}

function renderTitle(context) {
  context.fillStyle = "#FFFFFF";
  context.fillRect(0,0,canvas.width,canvas.height);

  drawFromTopLeft(title_screen, 0, 0);

  draw(one_player_button, 540, 216);
  draw(two_player_button, 540, 280); 
}

function renderGame(context) {
  drawFromTopLeft(background, 0, 0);

  if (h_count > 0) {
    draw(lightning_images[h_value % 4], 540 - 300 + 200 * (h_value % 4), 225);
  }

  for (var i = 0; i < explosions.length; i++) {
    explosion = explosions[i];
    draw(explosion_sprite, explosion.x, explosion.y);
  }

  for (var i = 0; i < right_bot.bullets.length; i++) {
    bullet = right_bot.bullets[i];
    draw(bullet.type, bullet.x, bullet.y);
  }

  for (var i = 0; i < left_bot.bullets.length; i++) {
    bullet = left_bot.bullets[i];
    draw(bullet.type, bullet.x, bullet.y);
  }

  // if (sub_mode != "intro_1") {
    // draw my robot boys
    draw(robot_images[left_bot.frame], left_bot.x, left_bot.y, false, left_bot.angle);
    draw(robot_images[right_bot.frame], right_bot.x, right_bot.y, true, right_bot.angle);
  // }

  if (sub_mode === "active") {
    player_1_health_fraction = left_bot.health / 1000.0;
    drawFromTopLeft(health_bar_fill, 10, 10, player_1_health_fraction);
    drawFromTopLeft(health_bar, 10, 10);

    player_2_health_fraction = right_bot.health / 1000.0;
    drawFromTopLeft(health_bar_fill, 1080 - 132, 10, player_2_health_fraction);
    drawFromTopLeft(health_bar, 1080 - 132, 10);
  }

  if (players === 1) {
    if (sub_mode === "active" || sub_mode === "dying" || sub_mode === "game_over") {
      if (player_1_display_score < player_1_score) player_1_display_score += 10;
      drawNumber(player_1_display_score, 5, 35);
    }
  } else if (players === 2) {
    if (sub_mode === "active" || sub_mode === "dying" || sub_mode === "game_over") {
      drawNumber(player_1_score, 5, 35);
      right_score = 1080 - 70;
      if (player_2_score >= 10) {
        right_score -= 27;
      }
      if (player_2_score >= 100) {
        right_score -= 27;
      }
      if (player_2_score >= 1000) {
        right_score -= 27;
      }
      if (player_2_score >= 10000) {
        right_score -= 27;
      }
      drawNumber(player_2_score, right_score, 35);
    }
  }

  if (sub_mode === "game_over") {
    draw(game_over_text, 500, 200);
    draw(press_space_text, 500, 250);
  }

  if (h_count > 0) {
    draw(h_images[h_value % 4], 540 - 300 + 200 * (h_value % 4), 410);
  }
  
  if (sub_mode === "intro_1" || sub_mode === "intro_2") {
    for (var i = 0; i < speed_lines.length; i++) {
      line = speed_lines[i];
      context.fillStyle = line.color;
      context.fillRect(line.x, line.y, line.width, line.height);
    }  
  }

  if (sub_mode == "intro_1") {
    if (round % 2 == 1) {
      draw(what_is_love, 540, 225);
    } else {
      draw(dont_hurt_me, 540, 225);
    }
  }

  if (sub_mode == "intro_2") {
    draw(round_text, 500, 225);
    drawNumber(round, 550, 200);
  }
}

function distance(x1, y1, x2, y2) {
  var x_diff = Math.abs(x1 - x2);
  var y_diff = Math.abs(y1 - y2);
  return Math.sqrt(x_diff*x_diff + y_diff*y_diff);
}

function handleKeydown(ev) {
  ev.preventDefault();

  if (ev.key === "m") {
    if (music) {
      $("#watiz").prop("volume", 0);
      music = false;
    } else {
      $("#watiz").prop("volume", 1);
      music = true;
    }
  }

  if (mode === "game") {
    handleGameKeydown(ev);
  } else if (mode === "title") {
    handleTitleKeydown(ev);
  }
}

function handleKeyup(ev) {
  ev.preventDefault();

  if (mode === "game") {
    handleGameKeyup(ev);
  }
}

key_pressed = {
  1: false,
  2: false,
  3: false,
  8: false,
  9: false,
  0: false,
};

function handleGameKeydown(ev) {
  if (sub_mode != "game_over" && sub_mode != "dying") {
    // if (player_1_keydown === false) {
      if (ev.key === "1" && key_pressed[1] === false) {
        player_1_choice = rock;
        key_pressed[1] = true;
        player_1_pressed = true;
      } else if (ev.key === "2" && key_pressed[2] === false) {
        player_1_choice = scissors;
        key_pressed[2] = true;
        player_1_pressed = true;
      } else if (ev.key === "3" && key_pressed[3] === false) {
        player_1_choice = paper;
        key_pressed[3] = true;
        player_1_pressed = true;
      }

      if (players === 2) {
        if (ev.key === "8" && key_pressed[8] === false) {
        player_2_choice = rock;
        key_pressed[8] = true;
        player_2_pressed = true;
      } else if (ev.key === "9" && key_pressed[9] === false) {
        player_2_choice = scissors;
        key_pressed[9] = true;
        player_2_pressed = true;
      } else if (ev.key === "0" && key_pressed[0] === false) {
        player_2_choice = paper;
        key_pressed[0] = true;
        player_2_pressed = true;
      }
      }
    // }
  }

  if (sub_mode === "game_over") {
    if (ev.key === " ") {
      initGame(1);
    }
  }
}

function handleGameKeyup(ev) {
  if (sub_mode != "game_over" && sub_mode != "dying") {
    if (ev.key === "1") {
      key_pressed[1] = false;
    } else if (ev.key === "2") {
      key_pressed[2] = false;
    } else if (ev.key === "3") {
      key_pressed[3] = false;
    }

    if (key_pressed[1] === false && key_pressed[2] === false && key_pressed[3] === false) {
      player_1_pressed = false;
    }

    if (players === 2) {
      if (ev.key === "8") {
        key_pressed[8] = false;
      } else if (ev.key === "9") {
        key_pressed[9] = false;
      } else if (ev.key === "0") {
        key_pressed[0] = false;
      }

      if (key_pressed[8] === false && key_pressed[9] === false && key_pressed[0] === false) {
        player_2_pressed = false;
      }
    }
  }
}



function handleTitleKeydown(ev) {
  if (ev.key === "1") {
    initGame(1);
  } else if(ev.key === "2") {
    initGame(2);
  }
}


