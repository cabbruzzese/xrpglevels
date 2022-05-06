Class XRpgSatyr : Actor
{
  Default
  {
    Health 400;
    Radius 18;
    Height 48;
    Scale 0.75;
    Speed 8;
    PainChance 50;
    Mass 350;
    SeeSound "satyr/sight";
    PainSound "CentaurPain";
    DeathSound "satyr/death";
    ActiveSound "minotaur/active";
    HitObituary "%o was mauled by a satyr.";
    MONSTER;
    +FLOORCLIP
    +AVOIDMELEE
  }

  States
  {
  Spawn:
    STYR AB 10 A_Look();
    Loop;
  See:
    STYR AABBCCDD 3 A_Chase();
    Loop;
  Melee:
    STYR EF 6 A_FaceTarget();
    STYR G 6 A_CustomMeleeAttack(8*Random(1, 8), "minotaur/attack1");
    STYR PQ 5 A_FaceTarget();
    STYR R 6 A_CustomMeleeAttack(8*Random(1, 8), "minotaur/attack1");
    Goto See;
  Missile:
    STYR A 8 A_SatyrChoose();
    STYR EF 6 A_FaceTarget();
    STYR G 6 A_FireProtect;
    STYR PQ 5 A_FaceTarget();
    STYR R 6 A_FireProtect;
    STYR EF 6 A_FaceTarget();
    STYR G 6 A_FireProtect;
    Goto See;
  WindAttack:
    STYR EF 6 A_FaceTarget();
    STYR G 6 A_FireWind;
    Goto See;
  Pain:
    STYR H 2;
    STYR H 2 A_Pain();
    Goto See;
  Death:
    STYR I 5;
    STYR J 5 A_Scream();
    STYR K 6;
    STYR L 7 A_Fall();
    STYR M 4;
    STYR N 4;
    STYR O -1;
    Stop;
  Raise:
    STYR ONMLKJI 8;
    Goto See;
    }

    action void A_SatyrChoose()
    {
        if (!target)
            return;
        
        if (random[SatyrAttack](1,2) == 1)
            SetStateLabel("WindAttack", true);
    }

    action void A_FireProtect()
    {
        int zPos = Pos.z + (Height / 2);
        A_StartSound ("ClericCStaffFire", CHAN_WEAPON);
        Actor mo = SpawnMissileZ (zPos, target, "SatyrMissileSeeker");
        if (mo)
            mo.tracer = invoker;
    }

    action void A_FireWind()
    {
        A_StartSound ("FireDemonAttack", CHAN_WEAPON);
        Actor mo = SpawnMissile (target, "SatyrFX");
    }
}

class SatyrMissileSeeker : Actor
{
	Default
	{
		Speed 10;
		Radius 8;
		Height 6;
		Damage 5;
		RenderStyle "Add";
		Projectile;
		DeathSound "ClericCStaffExplode";

		DamageType "Poison";

    Health 100;
	}
	States
	{
	Spawn:
		CSSF D 2 Bright A_SatyrMissileSeek;
        CSSF E 2 Bright;
		Loop;
	Death:
		CSSF FG 4 Bright;
		CSSF HI 3 Bright;
		Stop;
	}
	
    action void A_SatyrMissileSeek()
    {
        if (tracer && tracer.Health < 1)
        {
          if (tracer.target)
            tracer = tracer.target;
          else
            tracer = null;
        }
        A_SeekerMissile(50, 50, SMF_PRECISE);

        health--;

        if(health < 1)
        {
            SetStateLabel("Death");
        }
    }

	override int DoSpecialDamage (Actor target, int damage, Name damagetype)
	{
        if (!target)
            return 0;
        
        if (target.bIsMonster)
            return 0;
 
		// Satyr Spell does poison damage
		if (target.player)
		{
			target.player.PoisonPlayer (self, self.target, 20);
			damage >>= 1;
		}
		return damage;
	}

  override void Tick ()
  {
    Super.Tick();

    
  }
}

class SatyrFX : Actor
{
	Default
	{
		Speed 15;
		Radius 10;
		Height 6;
		Damage 3;
		DamageType "Ice";
		Projectile;
		+SPAWNSOUNDSOURCE
		+ZDOOMTRANS
		RenderStyle "Add";
		DeathSound "DemonMissileExplode";
	}
	States
	{
	Spawn:
        WRBL G 4 A_LeafSpawn(true);
		WRBL G 4 Bright A_LeafSpawn(false);
		Loop;
	Death:
		WRBL GHI 4 Bright;
		Stop;
	}

    void A_LeafSpawn(bool isPlaySound)
	{
        if (isPlaySound)
            A_StartSound("Wind", CHAN_BODY, CHANF_LOOPING);
        
		static const class<Actor> leaves[] = { "Leaf1", "Leaf2" };

		for (int i = random[LeafSpawn](1, 4); i; i--)
		{
			double xo = random2[LeafSpawn]() / 4.;
			double yo = random2[LeafSpawn]() / 4.;
			double zo = random[LeafSpawn]() / 4.;
			Actor mo = Spawn (leaves[random[LeafSpawn](0, 1)], Vec3Offset(xo, yo, zo), ALLOW_REPLACE);

			if (mo)
			{
				mo.Thrust(random[LeafSpawn]() / 128. + 3, angle);
				mo.target = self;
				mo.special1 = 0;
			}
		}
	}

    override int DoSpecialDamage (Actor target, int damage, Name damagetype)
    {
          if (!target)
              return 0;
          
          if (!target.bDONTTHRUST)
              target.Thrust(30, angle);

      return damage;
    }
}