//
//  SDCalculationUtil.m
//  ticdiary
//
//  Created by guobingwei on 2019/1/2.
//  Copyright © 2019年 guobingwei. All rights reserved.
//

#import "SDCalculationUtil.h"

const  int START_YEAR =1901;
const  int END_YEAR   =2050;

static int32_t gLunarHolDay[]=
{
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1901
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X87, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1902
    0X96, 0XA5, 0X87, 0X96, 0X87, 0X87, 0X79, 0X69, 0X69, 0X69, 0X78, 0X78,   //1903
    0X86, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X78, 0X87,   //1904
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1905
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1906
    0X96, 0XA5, 0X87, 0X96, 0X87, 0X87, 0X79, 0X69, 0X69, 0X69, 0X78, 0X78,   //1907
    0X86, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1908
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1909
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1910
    0X96, 0XA5, 0X87, 0X96, 0X87, 0X87, 0X79, 0X69, 0X69, 0X69, 0X78, 0X78,   //1911
    0X86, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1912
    0X95, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1913
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1914
    0X96, 0XA5, 0X97, 0X96, 0X97, 0X87, 0X79, 0X79, 0X69, 0X69, 0X78, 0X78,   //1915
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //1916
    0X95, 0XB4, 0X96, 0XA6, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X87,   //1917
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X77,   //1918
    0X96, 0XA5, 0X97, 0X96, 0X97, 0X87, 0X79, 0X79, 0X69, 0X69, 0X78, 0X78,   //1919
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //1920
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X87,   //1921
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X77,   //1922
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X87, 0X79, 0X79, 0X69, 0X69, 0X78, 0X78,   //1923
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //1924
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X87,   //1925
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1926
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X87, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1927
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1928
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //1929
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1930
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X87, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1931
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1932
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1933
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1934
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1935
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1936
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1937
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1938
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1939
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1940
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1941
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1942
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1943
    0X96, 0XA5, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1944
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //1945
    0X95, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X77,   //1946
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1947
    0X96, 0XA5, 0XA6, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //1948
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X79, 0X78, 0X79, 0X77, 0X87,   //1949
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X77,   //1950
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1951
    0X96, 0XA5, 0XA6, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //1952
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //1953
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X78, 0X79, 0X78, 0X68, 0X78, 0X87,   //1954
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1955
    0X96, 0XA5, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //1956
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //1957
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1958
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1959
    0X96, 0XA4, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //1960
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1961
    0X96, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1962
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1963
    0X96, 0XA4, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //1964
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1965
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1966
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1967
    0X96, 0XA4, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //1968
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1969
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1970
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1971
    0X96, 0XA4, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //1972
    0XA5, 0XB5, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1973
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1974
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X77,   //1975
    0X96, 0XA4, 0XA5, 0XB5, 0XA6, 0XA6, 0X88, 0X89, 0X88, 0X78, 0X87, 0X87,   //1976
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //1977
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X78, 0X87,   //1978
    0X96, 0XB4, 0X96, 0XA6, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X77,   //1979
    0X96, 0XA4, 0XA5, 0XB5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //1980
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X77, 0X87,   //1981
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //1982
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X77,   //1983
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X87,   //1984
    0XA5, 0XB4, 0XA6, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //1985
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //1986
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X79, 0X78, 0X69, 0X78, 0X87,   //1987
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86,   //1988
    0XA5, 0XB4, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //1989
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //1990
    0X95, 0XB4, 0X96, 0XA5, 0X86, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1991
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86,   //1992
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //1993
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1994
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X76, 0X78, 0X69, 0X78, 0X87,   //1995
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86,   //1996
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //1997
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1998
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1999
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86,   //2000
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //2001
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //2002
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //2003
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86,   //2004
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //2005
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //2006
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //2007
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X87, 0X78, 0X87, 0X86,   //2008
    0XA5, 0XB3, 0XA5, 0XB5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //2009
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //2010
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X78, 0X87,   //2011
    0X96, 0XB4, 0XA5, 0XB5, 0XA5, 0XA6, 0X87, 0X88, 0X87, 0X78, 0X87, 0X86,   //2012
    0XA5, 0XB3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X87,   //2013
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //2014
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //2015
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X87, 0X88, 0X87, 0X78, 0X87, 0X86,   //2016
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X87,   //2017
    0XA5, 0XB4, 0XA6, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //2018
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //2019
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X86,   //2020
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86,   //2021
    0XA5, 0XB4, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //2022
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //2023
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X96,   //2024
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86,   //2025
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //2026
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //2027
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X96,   //2028
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86,   //2029
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //2030
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //2031
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X96,   //2032
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X86,   //2033
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X78, 0X88, 0X78, 0X87, 0X87,   //2034
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //2035
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X96,   //2036
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86,   //2037
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //2038
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //2039
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X96,   //2040
    0XA5, 0XC3, 0XA5, 0XB5, 0XA5, 0XA6, 0X87, 0X88, 0X87, 0X78, 0X87, 0X86,   //2041
    0XA5, 0XB3, 0XA5, 0XB5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //2042
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //2043
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X88, 0X87, 0X96,   //2044
    0XA5, 0XC3, 0XA5, 0XB4, 0XA5, 0XA6, 0X87, 0X88, 0X87, 0X78, 0X87, 0X86,   //2045
    0XA5, 0XB3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X87,   //2046
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //2047
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA5, 0X97, 0X87, 0X87, 0X88, 0X86, 0X96,   //2048
    0XA4, 0XC3, 0XA5, 0XA5, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X86,   //2049
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X78, 0X78, 0X87, 0X87    //2050
    
};


@implementation SDCalHolidayItem

- (void)setWeekday:(NSString *)weekday {
    _weekday = weekday;
    
    // 星期几（注意，周日是“1”，周一是“2”。。。。）
    NSString *tmpWeekDayString = @"";
    switch (weekday.integerValue) {
        case 1: {
            tmpWeekDayString = @"周日";
        }
            break;
        case 2: {
            tmpWeekDayString = @"周一";
        }
            break;
        case 3: {
            tmpWeekDayString = @"周二";
        }
            break;
        case 4: {
            tmpWeekDayString = @"周三";
        }
            break;
        case 5: {
            tmpWeekDayString = @"周四";
        }
            break;
        case 6: {
            tmpWeekDayString = @"周五";
        }
            break;
        case 7: {
            tmpWeekDayString = @"周六";
        }
            break;
        default:
            break;
    }
    self.weekDayString = tmpWeekDayString;
}

@end


@implementation SDCalculationUtil

+ (NSDateFormatter *)dateFormatter
{
    NSDateFormatter *_dateFormatter;
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [_dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    }
    return _dateFormatter;
}

+ (NSDateFormatter *)strDateFormatter
{
    NSDateFormatter *_strDateFormatter;
    if (!_strDateFormatter) {
        _strDateFormatter = [[NSDateFormatter alloc] init];
        [_strDateFormatter setDateFormat:@"MM-dd"];
        [_strDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
        
    }
    return _strDateFormatter;
}

+ (NSDate *)baseDate
{
    NSDate *_baseDate;
    if (!_baseDate) {
        _baseDate = [self.dateFormatter dateFromString:@"1900-1-1"];
    }
    return _baseDate;
}

+ (NSUInteger)year:(NSDate *)date {
    NSDateComponents *comps = [self calculationThisMonthFirstDayInWeek:date];
    return [comps year];
}

+ (NSUInteger)month:(NSDate *)date {
    NSDateComponents *comps = [self calculationThisMonthFirstDayInWeek:date];
    return [comps month];
}

+ (NSUInteger)day:(NSDate *)date {
    NSDateComponents *comps = [self calculationThisMonthFirstDayInWeek:date];
    return [comps day];
}

+ (NSUInteger)dayInWeek:(NSDate *)date {
    NSDateComponents *comps = [self calculationThisMonthFirstDayInWeek:date];
    return [comps weekday];
}

+ (NSString *)yearMonthFormatter:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)yearMonthFormatterString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    
    return [dateFormatter dateFromString:dateString];
}

+ (NSDate *)yearMonthDayFormatter:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    
    return [dateFormatter dateFromString:dateString];
}

+ (NSString *)yearMonthDayStringFormatter:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    
    return [dateFormatter stringFromDate:date];
}

+ (BOOL)isCurrentDay:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    
    NSString *curDay = [dateFormatter stringFromDate:[NSDate date]];
    if (dateString && [dateString isEqualToString:curDay]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - 计算本月第一天是周几
+ (NSDateComponents *)calculationThisMonthFirstDayInWeek:(NSDate *)date {
    if (date == nil || date == NULL || [date isKindOfClass:[NSNull class]]) {
        date = [NSDate date];
    }
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents * comps = [[NSDateComponents alloc] init];
    NSDateComponents * theComps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear;
    comps = [calendar components:unitFlags fromDate:date];
    theComps = [calendar components:unitFlags fromDate:[NSDate date]];
//    [theComps month];// 本月的月份
    NSUInteger day = [comps day];// 是本月第几天
//    self.todayInMonth = day;
    NSString *dateStr = [self.dateFormatter stringFromDate:date];
    NSString *todayStr = [self.dateFormatter stringFromDate:[NSDate date]];
//    if (day > 1) {// 如果不是本月第一天
//        // 将日期推算到本月第一天
//        NSInteger hours = (day - 1) * -24;
//        date = [NSDate dateWithTimeInterval:hours * 60 * 60 sinceDate:date];
//    }
    comps = [calendar components:unitFlags fromDate:date];
    return comps;
}

#pragma mark - 计算二十四节气的具体日期
/**
 * @param year 年份
 * @param index 节气索引，0代表小寒，1代表大寒，其它节气按照顺序类推
 */
+ (NSString *)calculationSolarTermsWithYear:(NSUInteger)year solarTermsIndex:(NSUInteger)index
{
    NSString * solarTerms = @"";
    CGFloat base = 365.242 * (year - 1900) + 6.2 + (15.22 * index) - (1.9 * sinf(0.262 * index));// 计算积日
    NSInteger hours = (base - 1) * 24;// 由于基准日为1900年1月0日，所以这里需要-1
    NSDate * date = [NSDate dateWithTimeInterval:hours * 60 * 60 sinceDate:[self baseDate]];
    
    solarTerms = [[self strDateFormatter] stringFromDate:date];
    
    
    return solarTerms;
}

#pragma mark - 计算农历日期
+ (SDCalHolidayItem *)calculationChinaCalendarWithDate:(NSDate *)date dispalyHoliday:(BOOL)display
{
    if (date == nil || date == NULL || [date isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    NSArray * chineseYears = @[@"甲子", @"乙丑", @"丙寅", @"丁卯", @"戊辰", @"己巳", @"庚午", @"辛未", @"壬申", @"癸酉", @"甲戌", @"乙亥", @"丙子", @"丁丑", @"戊寅", @"己卯", @"庚辰", @"辛己", @"壬午", @"癸未", @"甲申", @"乙酉", @"丙戌", @"丁亥", @"戊子", @"己丑", @"庚寅", @"辛卯", @"壬辰", @"癸巳", @"甲午", @"乙未", @"丙申", @"丁酉", @"戊戌", @"己亥", @"庚子", @"辛丑", @"壬寅", @"癸丑", @"甲辰", @"乙巳", @"丙午", @"丁未", @"戊申", @"己酉", @"庚戌", @"辛亥", @"壬子", @"癸丑", @"甲寅", @"乙卯", @"丙辰", @"丁巳", @"戊午", @"己未", @"庚申", @"辛酉", @"壬戌", @"癸亥"];
    NSArray * chineseMonths = @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                                @"九月", @"十月", @"冬月", @"腊月"];
    NSArray * chineseDays = @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十", @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"廿十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"];
    
    NSCalendar * localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents * localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSString *chineseYear = [chineseYears objectAtIndex:localeComp.year - 1];
    NSString * m_str = [chineseMonths objectAtIndex:localeComp.month - 1];
    NSString *chineseMonth = m_str;
    
    NSString * d_str = [chineseDays objectAtIndex:localeComp.day - 1];
    
    NSString *chinaeseDay = [NSString stringWithFormat:@"%@ %@ %@",chineseYear,chineseMonth,d_str];

    NSString *chineseCal_str = [NSString stringWithFormat:@"%@ %@ %@",chineseYear,chineseMonth,d_str];
    NSString *cnDayString = d_str;
    NSString *colorBGString = nil;
    NSString *colorTitleString = @"FFFFFF";
    
    NSString *holidayString = @"";

    SDCalHolidayItem *item = [[SDCalHolidayItem alloc] init];
    
    // 农历节日
    if ([m_str isEqualToString:@"正月"] && [d_str isEqualToString:@"初一"]) {
        chineseCal_str = @"春节";
        cnDayString = chineseCal_str;
        colorBGString = @"ed5555";
        holidayString = chineseCal_str;
    } else if ([m_str isEqualToString:@"正月"] && [d_str isEqualToString:@"十五"]) {
        chineseCal_str = @"元宵节";
        cnDayString = chineseCal_str;
        colorBGString = @"ed5555";
        holidayString = chineseCal_str;
    } else if ([m_str isEqualToString:@"五月"] && [d_str isEqualToString:@"初五"]) {
        chineseCal_str = @"端午节";
        cnDayString = chineseCal_str;
        colorBGString = @"55ed55";
        holidayString = chineseCal_str;
    } else if ([m_str isEqualToString:@"七月"] && [d_str isEqualToString:@"初七"]) {
        chineseCal_str = @"七夕";
        cnDayString = chineseCal_str;
        colorBGString = @"EE6AA7";
        holidayString = chineseCal_str;

    } else if ([m_str isEqualToString:@"七月"] && [d_str isEqualToString:@"十五"]) {
        chineseCal_str = @"中元节";
        cnDayString = chineseCal_str;
        colorBGString = @"3B3B3B";
        holidayString = chineseCal_str;

    } else if ([m_str isEqualToString:@"八月"] && [d_str isEqualToString:@"十五"]) {
        chineseCal_str = @"中秋节";
        cnDayString = chineseCal_str;
        colorBGString = @"FFC125";
        holidayString = chineseCal_str;

    } else if ([m_str isEqualToString:@"九月"] && [d_str isEqualToString:@"初九"]) {
        chineseCal_str = @"重阳节";
        cnDayString = chineseCal_str;
        colorBGString = @"BCEE68";
        holidayString = chineseCal_str;

    } else if ([m_str isEqualToString:@"腊月"] && [d_str isEqualToString:@"初八"]) {
        chineseCal_str = @"腊八节";
        cnDayString = chineseCal_str;
        colorBGString = @"ff3a27";
        holidayString = chineseCal_str;

    } else if ([m_str isEqualToString:@"腊月"] && [d_str isEqualToString:@"廿三"]) {
        chineseCal_str = @"小年";
        cnDayString = chineseCal_str;
        colorBGString = @"EE9A00";
        holidayString = chineseCal_str;

    } else if ([m_str isEqualToString:@"腊月"] && [d_str isEqualToString:@"三十"]) {
        chineseCal_str = @"除夕";
        cnDayString = chineseCal_str;
        colorBGString = @"EE4000";
        holidayString = chineseCal_str;

    }
    
    // 公历节日
    NSDictionary * Holidays = @{@"01-01":@"元旦",
                                @"02-02":@"湿地日",
                                @"02-02":@"湿地日",
                                @"02-14":@"情人节",
                                @"03-08":@"妇女节",
                                @"03-12":@"植树节",
                                @"03-15":@"消费者权益日",
                                @"04-01":@"愚人节",
                                @"04-22":@"地球日",
                                @"05-01":@"劳动节",
                                @"05-18":@"博物馆日",
                                @"05-04":@"青年节",
                                @"06-01":@"儿童节",
                                @"06-05":@"环境日",
                                @"07-01":@"建党节",
                                @"08-01":@"建军节",
                                @"09-10":@"教师节",
                                @"10-01":@"国庆节",
                                @"12-01":@"艾滋病日",
                                @"12-24":@"平安夜",
                                @"12-25":@"圣诞节"};
    
    NSString * nowStr = [self.strDateFormatter stringFromDate:date];
    // 复活节, Meeus/Jones/Butcher算法
    NSUInteger a = [self year:date] % 19;
    NSUInteger b =  [self year:date] / 100;
    NSUInteger c =  [self year:date] % 100;
    NSUInteger d = b / 4;
    NSUInteger e = b % 4;
    NSUInteger f = (b + 8) / 25;
    NSUInteger g = (b - f + 1) / 3;
    NSUInteger h = (19 * a + b - d - g + 15) % 30;
    NSUInteger i = c / 4;
    NSUInteger k = c % 4;
    NSUInteger l = (32 + (2 * e) + (2 * i) - h - k) % 7;
    NSUInteger m = (a + (11 * h) + (22 * l)) / 451;
    NSUInteger theMonth = (h + l - (7 * m) + 114) / 31;
    NSUInteger day = ((h + l - (7 * m) + 114) % 31)+ 1;
    NSString * easter = [NSString stringWithFormat:@"0%@-%@", @(theMonth), @(day)];
    if ([easter isEqualToString:nowStr]) {
        chineseCal_str = @"复活节";
        cnDayString = chineseCal_str;
        colorBGString = @"FC3F51";
        holidayString = chineseCal_str;

    }
    
    NSArray * array = [Holidays allKeys];
    if([array containsObject:nowStr]) {
        chineseCal_str = [Holidays objectForKey:nowStr];
        cnDayString = chineseCal_str;
        colorBGString = @"FC3F51";
        holidayString = chineseCal_str;

    }
    
    // 公历礼拜节日
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents * comps = [[NSDateComponents alloc] init];
    NSInteger unit = NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekday;
    comps = [calendar components:unit fromDate:date];
    NSUInteger month = [comps month];
    
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    NSString *weekDayStr = [NSString stringWithFormat:@"%ld",(long)weekday];
    // 这个月的第几周
    NSInteger weekdayOrdinal = [comps weekdayOrdinal];
    NSUInteger dayInMonth = [comps day];
    switch (month) {
        case 5:
            //计算母亲节，母亲节为每年的5月份，第二个周日
            if (weekdayOrdinal == 2 && weekday == 1) {
                chineseCal_str = @"母亲节";
                colorBGString = @"FC3F51";
                cnDayString = chineseCal_str;
                holidayString = chineseCal_str;
            }
            break;
        case 6:
            if (weekdayOrdinal == 3 && weekday == 1) {
                chineseCal_str = @"父亲节";
                colorBGString = @"FC3F51";
                cnDayString = chineseCal_str;
                holidayString = chineseCal_str;
            }
            break;
        case 11:
            if (weekdayOrdinal == 4 && weekday == 5) {
                chineseCal_str = @"感恩节";
                colorBGString = @"FC3F51";
                cnDayString = chineseCal_str;
                holidayString = chineseCal_str;
            }
            break;
        default:
            break;
    }
    
    /*
    // 二十四节气, 将节气按月份拆开计算，否则由于计算积日所需日期转换stringFromDate方法过于耗时将会造成线程卡顿
    NSString * solarTerms = @"";
    switch ([self month:date]) {// 过滤月份
        case 1:
            for (NSInteger i = 0; i < 2; i ++) {
                solarTerms = [self calculationSolarTermsWithYear: [self year:date] solarTermsIndex:i];
                switch (i) {
                    case 0:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"小寒";
                            colorBGString = @"9ACD32";
                        }
                        break;
                    case 1:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"大寒";
                            colorBGString = @"9ACD32";
                        }
                        break;
                }
            }
            break;
        case 2:
            for (NSInteger i = 2; i < 4; i ++) {
                solarTerms = [self calculationSolarTermsWithYear: [self year:date] solarTermsIndex:i];
                switch (i) {
                    case 2:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"立春";
                            colorBGString = @"31b482";
                        }
                        break;
                    case 3:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"雨水";
                            colorBGString = @"90EE90";
                        }
                        break;
                }
            }
            break;
        case 3:
            for (NSInteger i = 4; i < 6; i ++) {
                solarTerms = [self calculationSolarTermsWithYear: [self year:date] solarTermsIndex:i];
                switch (i) {
                    case 4:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"惊蛰";
                            colorBGString = @"9ACD32";
                        }
                        break;
                    case 5:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"春分";
                            colorBGString = @"9ACD32";
                        }
                        break;
                }
            }
            break;
        case 4:
            for (NSInteger i = 6; i < 8; i ++) {
                solarTerms = [self calculationSolarTermsWithYear: [self year:date] solarTermsIndex:i];
                switch (i) {
                    case 6:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"清明";
                            colorBGString = @"9AC0CD";
                        }
                        break;
                    case 7:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"谷雨";
                            colorBGString = @"71C671";
                        }
                        break;
                }
            }
            break;
        case 5:
            for (NSInteger i = 8; i < 10; i ++) {
                solarTerms = [self calculationSolarTermsWithYear: [self year:date] solarTermsIndex:i];
                switch (i) {
                    case 8:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"立夏";
                            colorBGString = @"BCEE68";
                        }
                        break;
                    case 9:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"小满";
                            colorBGString = @"31b482";
                        }
                        break;
                }
            }
            break;
        case 6:
            for (NSInteger i = 10; i < 12; i ++) {
                solarTerms = [self calculationSolarTermsWithYear: [self year:date] solarTermsIndex:i];
                switch (i) {
                    case 10:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"芒种";
                            colorBGString = @"31b482";
                        }
                        break;
                    case 11:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"夏至";
                            colorBGString = @"31b482";
                        }
                }
            }
            break;
        case 7:
            for (NSInteger i = 12; i < 14; i ++) {
                solarTerms = [self calculationSolarTermsWithYear: [self year:date] solarTermsIndex:i];
                switch (i) {
                    case 12:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"小暑";
                            colorBGString = @"31b482";
                        }
                        break;
                    case 13:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"大暑";
                            colorBGString = @"31b482";
                        }
                    break;
                }
            }
            break;
        case 8:
            for (NSInteger i = 14; i < 16; i ++) {
                solarTerms = [self calculationSolarTermsWithYear:[self year:date] solarTermsIndex:i];
                switch (i) {
                    case 14:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"立秋";
                            colorBGString = @"EEAD0E";
                        }
                        break;
                    case 15:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"处暑";
                            colorBGString = @"EEAD0E";
                        }
                        break;
                }
            }
            break;
        case 9:
            for (NSInteger i = 16; i < 18; i ++) {
                solarTerms = [self calculationSolarTermsWithYear: [self year:date] solarTermsIndex:i];
                switch (i) {
                    case 16:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"白露";
                            colorBGString = @"EEAD0E";
                        }
                        break;
                    case 17:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"秋分";
                            colorBGString = @"EEAD0E";
                        }
                        break;
                }
            }
            break;
        case 10:
            for (NSInteger i = 18; i < 20; i ++) {
                solarTerms = [self calculationSolarTermsWithYear: [self year:date] solarTermsIndex:i];
                switch (i) {
                    case 18:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"寒露";
                            colorBGString = @"EEE9E9";
                        }
                        break;
                    case 19:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"霜降";
                            colorBGString = @"EEE9E9";
                        }
                        break;
                }
            }
            break;
        case 11:
            for (NSInteger i = 20; i < 22; i ++) {
                solarTerms = [self calculationSolarTermsWithYear: [self year:date] solarTermsIndex:i];
                switch (i) {
                    case 20:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"立冬";
                            colorBGString = @"EEE9E9";
                        }
                        break;
                    case 21:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"小雪";
                            colorBGString = @"EEE9E9";
                        }
                        break;
                }
            }
            break;
        case 12:
            for (NSInteger i = 22; i < 24; i ++) {
                solarTerms = [self calculationSolarTermsWithYear: [self year:date] solarTermsIndex:i];
                switch (i) {
                    case 22:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"大雪";
                            colorBGString = @"1874CD";
                        }
                        break;
                    case 23:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"冬至";
                            colorBGString = @"1874CD";
                        }
                        break;
                }
            }
            break;
    }
     */

    item.showDayString = d_str;
    item.colorBGString = colorBGString;
    item.cnDayString = cnDayString;
    
    item.chaineseDay = chinaeseDay;
    item.holiDay = holidayString;
    item.weekday = weekDayStr;
    if (display == YES) {// 需要显示假期&节日
        //return chineseCal_str;
        item.showDayString = chineseCal_str;
        item.colorBGString = colorBGString;
        item.cnDayString = cnDayString;
        item.holiDay = holidayString;
        return item;
    }

    return item;
}

//获取二十四节气
+ (SDCalHolidayItem *)getLunarSpecialDate:(NSDate *)date {
    if (date == nil || date == NULL || [date isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    NSArray *chineseDays = [NSArray arrayWithObjects:
                          @"小寒", @"大寒", @"立春", @"雨水", @"惊蛰", @"春分",
                          @"清明", @"谷雨", @"立夏", @"小满", @"芒种", @"夏至",
                          @"小暑", @"大暑", @"立秋", @"处暑", @"白露", @"秋分",
                          @"寒露", @"霜降", @"立冬", @"小雪", @"大雪", @"冬至", nil];
    
    NSArray *dayBGColors = [NSArray arrayWithObjects:
                            @"AEEEEE", @"CAE1FF", @"05d96a", @"05dd6a", @"05dd6a", @"31b482",
                            @"4682B4", @"CDC673", @"CDCD00", @"66CDAA", @"87CEFA", @"00EEEE",
                            @"00E5EE", @"00F5FF", @"EEE8AA", @"EEDC82", @"EEE0E5", @"EE9A00",
                            @"E5E5E5", @"EAEAEA", @"F0F8FF", @"F0F8FF", @"F0F8FF", @"F0F8FF", nil];
    
    NSArray *dayTitleColors = [NSArray arrayWithObjects:
                            @"A0522D", @"B8860B", @"BFEFFF", @"BFEFFF", @"BFEFFF", @"BFEFFF",
                            @"FFFFFF", @"006400", @"8B2323", @"FFFFFF", @"53868B", @"008B8B",
                            @"00868B", @"00688B", @"CD6600", @"CD6600", @"CD6839", @"A52A2A",
                            @"8B1A1A", @"8B1A1A", @"00688B", @"218868", @"00688B", @"218868", nil];
    
    NSString *dateString = [[self dateFormatter] stringFromDate:date];
    if (!(dateString && dateString.length > 0)) {
        return nil;
    }
    
    NSArray *dateArray = [dateString componentsSeparatedByString:@"-"];
    if (dateArray.count == 3) {
        
        SDCalHolidayItem *item = [[SDCalHolidayItem alloc] init];
        
        int iYear = [[dateArray objectAtIndex:0] intValue];
        int iMonth = [[dateArray objectAtIndex:1] intValue];
        int iDay = [[dateArray objectAtIndex:2] intValue];
        
        int array_index = (iYear - START_YEAR)*12+iMonth -1 ;
        
        int64_t flag = gLunarHolDay[array_index];
        int64_t day;
        
        if(iDay <15)
            day= 15 - ((flag>>4)&0x0f);
        else
            day = ((flag)&0x0f)+15;
        
        int index = -1;
        
        if(iDay == day){
            index = (iMonth-1) *2 + (iDay>15? 1: 0);
        }
        
        if ( index >= 0  && index < [chineseDays count] ) {
            item.showDayString = [chineseDays objectAtIndex:index];
            item.colorString = [dayTitleColors objectAtIndex:index];
            item.colorBGString = [dayBGColors objectAtIndex:index];
            return item;
        } else {
            return nil;
        }
    }
    
    return nil;
}

#pragma mark - 日历
+ (int)getNumberOfMonth:(NSDate*)date
{
    NSCalendar  *cal = [NSCalendar  currentCalendar];
    NSRange range = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    int numberOfDays = range.length;
    return numberOfDays;
}

+ (NSDate *)getMonthFirstDay:(NSDate*)tdate
{
    NSDate *nowdate = tdate;
    NSCalendar  *cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit;
    NSDateComponents *conponent= [cal components:unitFlags fromDate:nowdate];
    conponent.day = 1;
    NSDate *firstDate = [cal dateFromComponents:conponent];
    return firstDate;
}

+ (int)getWeekOfMonthFirstDay:(NSDate*)tdate
{
    NSDate *nowdate = [self getMonthFirstDay:tdate];
    NSCalendar  *cal=[NSCalendar  currentCalendar];
    NSDateComponents *comps = [cal components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
                                     fromDate:nowdate];
    //NSInteger week = [comps week]; // 今年的第几周
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    //NSInteger weekdayOrdinal = [comps weekdayOrdinal]; // 这个月的第几周
    return weekday;
}

+(int)getNumberDaysOfLastMonth:(NSDate*)tdate
{
    NSDate *nowdate = tdate;
    NSCalendar  *cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:nowdate];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    [conponent setMonth:([conponent month] - 1)];
    NSDate *lastMonth = [cal dateFromComponents:conponent];
    int lastmonthNumbersDay = [self getNumberOfMonth:lastMonth];
    return lastmonthNumbersDay;
}

+(NSDate*)getDateOfNextMonth:(NSDate*)tdate
{
    NSDate *nowdate = tdate;
    NSCalendar  *cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:nowdate];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    [conponent setMonth:([conponent month] + 1)];
    NSDate *preMonth = [cal dateFromComponents:conponent];
    return preMonth;
}

+(NSDate*)getDateOfLastMonth:(NSDate*)tdate
{
    NSDate *nowdate = tdate;
    NSCalendar  *cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:nowdate];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    [conponent setMonth:([conponent month] - 1)];
    NSDate *lastMonth = [cal dateFromComponents:conponent];
    return lastMonth;
}

+(int)numDaysInMonth:(NSDate *)tdate{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange rng = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:tdate];
    NSUInteger numberOfDaysInMonth = rng.length;
    return numberOfDaysInMonth;
}

+(NSDate *)dateStartOfDay:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components =
    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |
                           NSDayCalendarUnit) fromDate: date];
    return [gregorian dateFromComponents:components];
}


+(NSDate *)dateStartOfWeek {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: - ((([components weekday] - [gregorian firstWeekday])
                                      + 7 ) % 7)];
    NSDate *beginningOfWeek = [gregorian dateByAddingComponents:componentsToSubtract toDate:[NSDate date] options:0];
    
    NSDateComponents *componentsStripped = [gregorian components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                        fromDate: beginningOfWeek];
    
    //gestript
    beginningOfWeek = [gregorian dateFromComponents: componentsStripped];
    
    return beginningOfWeek;
}

+(NSDate *)dateEndOfWeek {
    NSCalendar *gregorian =[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    
    
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay: + (((([components weekday] - [gregorian firstWeekday])
                                  + 7 ) % 7))+6];
    NSDate *endOfWeek = [gregorian dateByAddingComponents:componentsToAdd toDate:[NSDate date] options:0];
    
    NSDateComponents *componentsStripped = [gregorian components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                        fromDate: endOfWeek];
    
    //gestript
    endOfWeek = [gregorian dateFromComponents: componentsStripped];
    return endOfWeek;
}

+(int)firstWeekDayInMonth:(NSDate*)tdate {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:2]; //monday is first day
    //[gregorian setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
    
    //Set date to first of month
    NSDateComponents *comps = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:tdate];
    [comps setDay:1];
    NSDate *newDate = [gregorian dateFromComponents:comps];
    
    return [gregorian ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:newDate];
}

+(int)numRowsNumberOfMonth:(NSDate *)tdate
{
    float lastBlock = [self numDaysInMonth:tdate]+([self firstWeekDayInMonth:tdate]-1);
    return ceilf(lastBlock/7);
}


@end
