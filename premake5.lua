project "NFD-Extended"
    kind "StaticLib"
    language "C++"
    cppdialect "C++20"
    staticruntime "Off"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files { "src/include/nfd.h", "src/include/nfd.hpp" }
    includedirs { "src/include/" }

    filter "system:windows"
		systemversion "latest"

        files { "src/nfd_win.cpp" }

    filter "system:linux"
		pic "On"
		systemversion "latest"

        files { "src/nfd_gtk.cpp" }

        result, err = os.outputof("pkg-config --cflags gtk+-3.0")
        buildoptions { result }

    filter "configurations:Debug"
        runtime "Debug"
        symbols "On"

    filter "configurations:Release"
		runtime "Release"
		optimize "speed"

    filter "configurations:Dist"
		runtime "Release"
		optimize "speed"
        symbols "off"