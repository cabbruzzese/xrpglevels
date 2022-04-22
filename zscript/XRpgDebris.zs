class ColdWaterSplash : Actor
{
	default
	{
		Radius 2;
		Height 4;
		Gravity 0.125;
		+NOBLOCKMAP 
		+MISSILE 
		+DROPOFF
		+NOTELEPORT
		+CANNOTPUSH
		+DONTSPLASH
		+DONTBLAST
	}
	States
	{
	Spawn:
		ICPR IJKL 4;
		ICPR M 4;
		Stop;
	Death:
		ICPR M 4;
		Stop;
	}
}


class ColdWaterSplashBase : Actor
{
	default
	{
		+NOBLOCKMAP
		+NOCLIP
		+NOGRAVITY
		+DONTSPLASH
		+DONTBLAST
		+MOVEWITHSECTOR
	}
	States
	{
	Spawn:
		ICWS ABCDEFGH 4;
		Stop;
	}
}