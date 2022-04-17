class XRpgMinotaurBoss : Minotaur
{
    Default
	{
        Health 6000;
        Scale 2.0;
        Height 160;
        Radius 32;
        Speed 28;
        Damage 12;
        MeleeRange 60;

    }

    States
    {
        Death:
            SMT1 Q 6;
            SMT1 R 6 A_Scream();
            SMT1 STU 6;
            SMT1 V 6 A_NoBlocking();
            SMT1 X 12;
            SMT1 Y -1 A_BossDeath();
            Stop;
    }
}