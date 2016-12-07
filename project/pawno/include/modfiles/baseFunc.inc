stock BaseGetInt(fieldi[],&permi)
{
 new fetch[128];
 mysql_fetch_field_row(fetch,fieldi);
 permi = strval(fetch);
}
stock BaseSetInt(base[],fields[],perms,opredelitel[],name[])
{
    new query[256];
    format(query,512,"UPDATE `%s` SET `%s` = '%d' WHERE `%s` = '%s'",base,fields,perms,opredelitel,name);
    mysql_query(query);
}
stock BaseGet(fields[],perms[])
{
 new fetch[128];
 mysql_fetch_field_row(fetch,fields);
 strmid(perms, fetch, 0, strlen(fetch), 255);
}
stock BaseSet(base[],fields[],perms[],opredelitel[],name[])
{
	mysql_real_escape_string(perms,perms);
	new query[512];
	format(query,512,"UPDATE `%s` SET `%s` = '%s' WHERE `%s` = '%s'",base,fields,perms,opredelitel,name);
	mysql_query(query);
}
stock BaseGetFloat(fieldf[],&Float:permf)
{
    new fetch[256];
    mysql_fetch_field_row(fetch,fieldf);
    permf = floatstr(fetch);
}
stock BaseSetFloat(base[],fields[],Float:perms,opredelitel[],name[])
{
    new query[128];
    format(query,sizeof(query),"UPDATE `%s` SET `%s` = '%f' WHERE `%s` = '%s'",base,fields,perms,opredelitel,name);
    mysql_query(query);
}