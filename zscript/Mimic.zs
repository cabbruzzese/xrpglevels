Class Mimic : Actor
{
  Default
  {
    Obituary "%o was killed by a mimic";
    Health 400;
    Radius 24;
    Height 112;
    Scale 0.75;
    Mass 0x7FFFFFFF; // [Blue Shadow] "infinite" mass
    PainChance 96;
    SeeSound "monster/tensit";
    PainSound "monster/tenpai";
    DeathSound "monster/tendth";
    ActiveSound "monster/tenact";
    Monster;
    DeathHeight 48;
    +BOSS
    +FLOORCLIP
    +DONTHARMCLASS
    +NOTARGET
    +MISSILEEVENMORE
    +DONTTHRUST
  }

  States
  {
  Spawn:
    CHST A 10 A_Look();
    Loop;
  See:
    CHSM ABCD 4;
  SeeLoop:
    CHSM EFGH 4 A_Chase();
    Loop;
  Missile:
    CHSM F 5 A_FaceTarget();
    CHSM I 8 A_FaceTarget();
    CHSM J 9 Bright A_SpawnProjectile("TentacleBall1", 100, 0, 0, CMF_OFFSETPITCH, -10);
    CHSM I 8 A_FaceTarget();
    CHSM J 9 Bright A_SpawnProjectile("TentacleBall1", 100, 0, 0, CMF_OFFSETPITCH, -10);
    CHSM I 8 A_FaceTarget();
    CHSM J 9 Bright A_SpawnProjectile("TentacleBall1", 100, 0, 0, CMF_OFFSETPITCH, -10);
    CHSM I 8;
    Goto SeeLoop;
  Pain:
    CHSM L 3;
    CHSM L 3 A_Pain();
    Goto SeeLoop;
  Death:
    CHSM M 4;
    CHSM N 4 A_Scream();
    CHSM O 4;
    CHSM PQRS 4;
    CHST B -1;
    Stop;
  Raise:
    CHST B 4 A_SetInvulnerable;
    CHSM ABCD 4;
    CHSM D 4 A_UnSetInvulnerable;
    Goto SeeLoop;
  }
}

Class TentacleBall1 : Actor
{
  Default
  {
    Radius 4;
    Height 4;
    Speed 10;
    Damage 7;
    RenderStyle "Add";
    Alpha 0.75;
    SeeSound "monster/tenatk";
    DeathSound "BishopMissileExplode";
    Projectile;
    Gravity 0.1;
    +RANDOMIZE
    -NOGRAVITY
  }

  States
  {
  Spawn:
    TNFX LM 3 Bright;
    Loop;
  Death:
    TNFX NOP 6 Bright;
    Stop;
  }
}