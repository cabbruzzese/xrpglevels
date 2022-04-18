class MageMonster : Actor
{
    action void A_FireVerticalMissile(Class<Actor> missileTypeName, int xSpread = 0, int ySpread = 0, int zSpeed = -90, int xMod = 0, int yMod = 0)
	{
		Actor mo = SpawnPlayerMissile(missileTypeName);
		if (!mo) return;

		double offsetX = 0;
		double offsetY = 0;
		if (xSpread > 0)
			offsetX = frandom[VerticleMissile](-xSpread, xSpread);		
		if (ySpread > 0)
			offsetY = frandom[VerticleMissile](-ySpread, ySpread);
		
		int newX = xMod + offsetX;
		int newY = yMod + offsetY;
        double newz = mo.CurSector.HighestCeilingAt((newX, newY));
        mo.SetOrigin((newX, newY, newz), false);

		mo.Vel.X = MinVel; // Force collision detection
        mo.Vel.Y = MinVel; // Force collision detection
		mo.Vel.Z = zSpeed;
		mo.CheckMissileSpawn (radius);
	}
}