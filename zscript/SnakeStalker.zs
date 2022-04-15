class RegenActor : Actor
{
	int regenHeal;
	int regenMax;
	int regenCounter;
	int regenTimeout;
	
	property RegenHeal : regenHeal;
	property RegenMax : regenMax;
	property RegenTimeout : regenTimeout;
	
	Default
	{
		RegenActor.RegenHeal 1;
		RegenActor.RegenTimeout 15;
		RegenActor.RegenMax 10;
	}
	
	override void Tick()
	{
		super.Tick();
		
		if (Health > 0)
		{
			regenCounter++;
		
			if (regenCounter > RegenTimeout)
			{
				regenCounter = 0;
				if (Health < RegenMax)
					GiveBody(RegenHeal);
			}
		}
	}
}

class SnakeStalker : RegenActor
{	
	Default
	{	
		Health 300;
		Radius 20;
		Height 60;
		Speed 12;
		MONSTER;
		SeeSound "SerpentSight";
		AttackSound "SerpentAttack";
		PainSound "SerpentPain";
		DeathSound "SerpentDeath";
		Obituary "$OB_SNAKESSTALKER";
		HitObituary "$OB_SERPENTHIT";
		Tag "$FN_SNAKESERPENT";
		+AVOIDMELEE
		+FLOORCLIP
		
		RegenActor.RegenHeal 5;
		RegenActor.RegenMax 150; //can heal back up to half health
	}
	States
	{
		Spawn:
			SIMP A 1 A_DecideMelee;
			SIMP AB 8 A_Look;
			Loop;
		See:
			SIMP AABBCCDD 4 A_Chase;
			Loop;
		Melee:
		Missile:
			SIMP EF 8 A_FaceTarget;
			SIMP G 8 A_CustomComboAttack("SerpentFX",40,10,"SerpentAttack");
			Goto See;
		Pain:
			SIMP H 4 A_Pain;
			SIMP H 4;
			Goto See;
		Death:
			SIMP I 6;
			SIMP J 6 A_Scream;
			SIMP KL 6;
			SIMP M 6 A_Fall;
			SIMP M -1;
			Stop;
		XDeath:
			SIMP N 6;
			SIMP O 6 A_XScream;
			SIMP P 6 ;
			SIMP Q 6 A_Fall;
			SIMP RST 6;
			SIMP U -1;
			Stop;
		Raise:
			SIMP LKJI 5;
			Goto See;
	}
	
	action void A_DecideMelee()
	{
		if (random(1,2) == 1)
			bAVOIDMELEE = false;
	}
}
