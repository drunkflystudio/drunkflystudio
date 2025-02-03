#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <stdio.h>

int main()
{
    DWORD dwVersion = GetVersion();
    DWORD dwMajorVersion = LOBYTE(LOWORD(dwVersion));
    DWORD dwMinorVersion = HIBYTE(LOWORD(dwVersion));
    printf("%d;%d", (int)dwMajorVersion, (int)dwMinorVersion);
    return (int)dwMajorVersion;
}
