# Dodger-v0.1
Warm-up tiny HTML5 dodging game.
Simple dodging game prototype in Godot 4 LTS.

## Day 1 Progress
- Main scene with UI layer, background, debug label.
- Player (CharacterBody2D) with Sprite2D + CollisionShape2D.
- Custom sprite created in Piskel.
- Basic movement via WASD / arrow keys.

## Day 2 Progress
- Added arena walls (StaticBody2D) to contain the player.
- Created hazard.tscn (bomb Area2D with sprite + collision).
- Implemented hazard.gd (falling bombs, despawn with explosion).
- Created explosion.tscn (auto-deletes via Timer).
- Built hazard_spawner.tscn (random X spawn, Timer-based).
- Integrated hazards into Main scene.
- Player collisions with bombs now trigger explosions.
- Added Game Over system (label shown, freeze via Engine.time_scale).
- Restart flow implemented (press R to reset run).
