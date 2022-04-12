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