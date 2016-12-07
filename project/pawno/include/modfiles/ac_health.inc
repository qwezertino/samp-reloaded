static Float:ac_hp__health[MAX_PLAYERS]; 

public OnPlayerUpdate(playerid)
{
        // код перехвата вынесен в отдельный блок,
    {    // чтобы после его выполнения переменные не занимали место в стеке
        new Float:health;
        GetPlayerHealth(playerid, health);
        // если кол-во HP изменилось с момента предыдущего обновления
        // сравниваемые значения трактуются, как целочисленные, чтобы избежать лишнего вызова floatcmp
        // (внимание! такой оптимизационный приём можно применять только при сравнении
        // с помощью знаков "==" и "!=", но ни в коем случае не с ">", "<", ">=" или "<=")
        if(_:ac_hp__health[playerid] != _:health)
        {
        // если игрок потерял HP, упав с высоты или с помощью чита - запоминаем новое значение
        // (пусть отнимает HP читами сколько угодно, всё равно восстановить его он уже не сможет)
            if(ac_hp__health[playerid] > health)
            {
                ac_hp__health[playerid] = health;
            }
            // если HP больше, чем записано в античите - HAX detected!
            else if(ac_hp__health[playerid] < health)
            {
                SetPlayerHealth(playerid, ac_hp__health[playerid]);
				SendCheaterToAdmins(playerid,7,0);
            }
        }
    }
    // на wiki.sa-mp.com написано, что возвращаемое коллбэком значение ни на что не влияет
    // и может быть пропущено, поэтому не стоит "требовать" это значение у перехватываемой функции -
    // вместо этого лучше использовать "return 1" отдельно от её вызова
#if    defined    ac_hp__OnPlayerUpdate
    ac_hp__OnPlayerUpdate(playerid);
#endif
    return 1;
}
#if    defined    _ALS_OnPlayerUpdate
    #undef    OnPlayerUpdate
#else
    #define    _ALS_OnPlayerUpdate
#endif
#define    OnPlayerUpdate    ac_hp__OnPlayerUpdate
#if    defined    ac_hp__OnPlayerUpdate
forward ac_hp__OnPlayerUpdate(playerid);
#endif  

public OnPlayerSpawn(playerid)
{
    ac_hp__health[playerid] = PlayerInfo[playerid][pHealth];//100.0;
#if    defined    ac_hp__OnPlayerSpawn
    ac_hp__OnPlayerSpawn(playerid);
#endif
    return 1;
}
#if    defined    _ALS_OnPlayerSpawn
    #undef    OnPlayerSpawn
#else
    #define    _ALS_OnPlayerSpawn
#endif
#define    OnPlayerSpawn    ac_hp__OnPlayerSpawn
#if    defined    ac_hp__OnPlayerSpawn
forward ac_hp__OnPlayerSpawn(playerid);
#endif  


stock ac_hp__GetPlayerHealth(playerid, &Float:health)
{
    health = ac_hp__health[playerid];
    return 1;
}
#if    defined    _ALS_GetPlayerHealth
    #undef    GetPlayerHealth
#else
    #define    _ALS_GetPlayerHealth
#endif
#define GetPlayerHealth ac_hp__GetPlayerHealth  



stock ac_hp__SetPlayerHealth(playerid, &Float:health)
{
    ac_hp__health[playerid] = health;
    return SetPlayerHealth(playerid, health);
}
#if    defined    _ALS_SetPlayerHealth
    #undef    SetPlayerHealth
#else
    #define    _ALS_SetPlayerHealth
#endif
#define SetPlayerHealth ac_hp__SetPlayerHealth  

