class DevilPillar : Actor
{
	Default
	{
		Radius 16;
		Height 256;
		+SOLID
		Scale 0.5;
	}
	States
	{
	Spawn:
		DPIL A -1;
		Stop;
	}
}

class DevilPillarMedium : Actor
{
	Default
	{
		Radius 16;
		Height 172;
		+SOLID
		Scale 0.5;
	}
	States
	{
	Spawn:
		DPIL B -1;
		Stop;
	}
}

class DevilPillarSmall : Actor
{
	Default
	{
		Radius 16;
		Height 128;
		+SOLID
		Scale 0.5;
	}
	States
	{
	Spawn:
		DPIL C -1;
		Stop;
	}
}

class BarStool : Actor
{
	Default
	{
		Radius 16;
		Height 48;
		+SOLID
	}
	States
	{
	Spawn:
		STOL A -1;
		Stop;
	}
}

class BarStoolSmall : Actor
{
	Default
	{
		Radius 16;
		Height 24;
		+SOLID
	}
	States
	{
	Spawn:
		STOL B -1;
		Stop;
	}
}

class LargeXmasTree : ZXmasTree
{
	Default
	{
		Radius 22;
		Height 260;
		Health 200;
		Scale 2.0;
	}
}

class FlourSack : Actor
{
	Default
	{
		Radius 16;
		Height 48;
		+SOLID
	}
	States
	{
	Spawn:
		SACK A -1;
		Stop;
	}
}

class IonicColumn : Actor //Like raa-a-ain on your wedding day
{
	Default
	{
		Radius 20;
		Height 128;
		+SOLID
	}
	States
	{
	Spawn:
		ICOL A -1;
		Stop;
	}
}

class GreatMinotaurStatue : Actor
{
	Default
	{
		Radius 32;
		Height 128;
		+SOLID
	}
	States
	{
	Spawn:
		ICOL A -1;
		Stop;
	}
}

class GreatFireBull : ZFireBull
{
	Default
	{
		Radius 32;
		Height 160;
		Scale 2.0;
	}

	States
	{
	Active:
		FBUL J 8 Bright A_StartSound("Ignite");
		FBUL IKLMNOPQ 8 Bright;
		FBUL R 8 A_NoBlocking;
		FBUL S 8 A_SpawnBoss;
		FBUL S -1;
		Stop;
	Spawn:
		FBUL ABCDEFG 4 Bright;
		Loop;
	Inactive:
		FBUL JI 4 Bright;
		FBUL H -1;
		Stop;
	}

	action void A_SpawnBoss ()
	{
		A_NoBlocking();
		Actor mo = Spawn("XRpgMinotaurBoss", invoker.Pos, ALLOW_REPLACE);
		if (mo)
		{
			mo.Angle = invoker.Angle;

			if (invoker.Args[0] != 0)
			{
				mo.Special = 80;
				mo.Args[0] = invoker.Args[0];
			}
		}
	}
}