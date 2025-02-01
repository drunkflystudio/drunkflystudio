
add_compiler_flag(-w- FORCE)                # disable all warnings by default

macro(enable_warnings)
    add_compiler_flag_release(-w! FORCE)    # treat warnings as errors
    add_compiler_flag(-wamb FORCE)          # ambiguous operators need parentheses
    add_compiler_flag(-wamp FORCE)          # superfluous & with function
    add_compiler_flag(-wasc FORCE)          # restarting compile using assembly
    add_compiler_flag(-wasm FORCE)          # unknown assembler instruction
    add_compiler_flag(-waus FORCE)          # variable is assigned a value that is never used
    add_compiler_flag(-wali FORCE)          #+ incorrect use of #pragma alias "aliasName"="substituteName"
    add_compiler_flag(-watr FORCE)          #+ attribute directive ignored
    add_compiler_flag(-wadt FORCE)          #+ cannot allocate arrays of Delphi style class
    add_compiler_flag(-wbbf FORCE)          # bit fields must be signed or unsigned int
    add_compiler_flag(-wbei FORCE)          # initialization with a different type
    add_compiler_flag(-wbig FORCE)          # hexadecimal value contains too many digits
    add_compiler_flag(-wbex FORCE)          #+ base class of dllexport class should also be dllexport
    add_compiler_flag(-wbcx FORCE)          #+ base class of exported class should have exported constructor
    add_compiler_flag(-wccc FORCE)          # condition is always true/false
    add_compiler_flag(-wcln FORCE)          # constant is long
    add_compiler_flag(-wcom FORCE)          #+ continuation character \ found in // comment
    add_compiler_flag(-wcpt FORCE)          # nonportable pointer comparison
    add_compiler_flag(-wcsu FORCE)          #+ comparing signed and unsigned values
    add_compiler_flag(-wcod FORCE)          #+ incorrect use of #pragma codeseg
    add_compiler_flag(-wcni FORCE)          #+ constant in new expression requires an initializer
    add_compiler_flag(-wdef FORCE)          # possible use of symbol before definition
    add_compiler_flag(-wdig FORCE)          #+ declaration ignored
    add_compiler_flag(-wdpu FORCE)          # declare symbol prior to use in prototype
    add_compiler_flag(-wdsz FORCE)          # array size for 'delete' ignored
    add_compiler_flag(-wdup FORCE)          # redefinition of '%s' is not identical
    add_compiler_flag(-wdep FORCE)          #+ use of deprecated syntax
    add_compiler_flag(-wdtp FORCE)          #+ parameter is a dependent type
    add_compiler_flag(-wdpr FORCE)          #+ accessing deprecated entity
    add_compiler_flag(-wdex FORCE)          #+ unresolved dependencies in expression
    add_compiler_flag(-wdlx FORCE)          #+ function defined with different linkage
    add_compiler_flag(-wdim FORCE)          #+ can't import a function being defined
    add_compiler_flag(-wdgu FORCE)          #+ interface does not have a GUID
    add_compiler_flag(-wdiu FORCE)          #+ interface does not derive from IUnknown
    add_compiler_flag(-wdin FORCE)          #+ casting Delphi style class to an interface
    add_compiler_flag(-wdns FORCE)          #+ support for declspec not implemented.
    add_compiler_flag(-weas FORCE)          # assignment of incompatible types
    add_compiler_flag(-weff FORCE)          # code has no effect
    add_compiler_flag(-wext FORCE)          # symbol is declared as both external and static
    add_compiler_flag(-wexc FORCE)          #+ extern C linkage ignored
    add_compiler_flag(-weoi FORCE)          #+ dllexport overrides previous dllimport
    add_compiler_flag(-whch FORCE)          # handler hidden by previous handler
    add_compiler_flag(-whid FORCE)          # function hides virtual function
    add_compiler_flag(-wias FORCE)          #+ array variable is near
    add_compiler_flag(-wibc FORCE)          # base class is also a base class of other class
    add_compiler_flag(-will FORCE)          # ill-formed pragma
    add_compiler_flag(-winl FORCE)          # functions are not expanded inline
    add_compiler_flag(-wifr FORCE)          #+ function redefined as non-inline
    add_compiler_flag(-wimp FORCE)          #+ implicit conversion of type to type
    add_compiler_flag(-wiex FORCE)          # inline function was declared with 'extern template'
    add_compiler_flag(-winc FORCE)          #+ constant expression expected; statement ignored
    add_compiler_flag(-wiip FORCE)          #+ inline member function in Package class
    add_compiler_flag(-wiac FORCE)          #+ found invalid character from source code in the current text locale
    add_compiler_flag(-wind FORCE)          #+ casting interface to Delphi style class
    add_compiler_flag(-witl FORCE)          #+ initialization of TLS data is not supported on this platform
    add_compiler_flag(-wlin FORCE)          # temporary used as initializer
    add_compiler_flag(-wlvc FORCE)          # temporary used for parameter
    add_compiler_flag(-wmpc FORCE)          # conversion will fail for members of virtual base
    add_compiler_flag(-wmpd FORCE)          # maximum precision used for member pointer type
    add_compiler_flag(-wmsg FORCE)          # #pragma message
    add_compiler_flag(-wmes FORCE)          #+ incorrect use of #pragma message
    add_compiler_flag(-wmcs FORCE)          #+ incorrect use of #pragma code_seg
    add_compiler_flag(-wmcc FORCE)          #+ multi-character character constant
    add_compiler_flag(-wmls FORCE)          #+ local Static with constructor dangerous for multi-threaded apps
    add_compiler_flag(-wmnc FORCE)          #+ member in class without constructors
    add_compiler_flag(-wmal FORCE)          #+ alignment reduced
    add_compiler_flag(-wmtx FORCE)          #+ dllexport class member should be of exported type
    add_compiler_flag(-wnak FORCE)          # non-ANSI keyword used
    add_compiler_flag(-wncf FORCE)          # non-const function called for const object
    add_compiler_flag(-wnci FORCE)          # constant member is not initialized
    add_compiler_flag(-wncl FORCE)          #+ constructor initializer list ignored
    add_compiler_flag(-wnfd FORCE)          #+ function body ignored
    add_compiler_flag(-wngu FORCE)          #+ negating unsigned value
    add_compiler_flag(-wnin FORCE)          #+ initializer for object ignored
    add_compiler_flag(-wnma FORCE)          #+ macro definition ignored
    add_compiler_flag(-wnmu FORCE)          #+ #undef directive ignored
    add_compiler_flag(-wnod FORCE)          # no declaration for function
    add_compiler_flag(-wnsf FORCE)          # declaration of static function ignored
    add_compiler_flag(-wnst FORCE)          # use qualified name to access member type
    add_compiler_flag(-wntd FORCE)          # use '> >' for nested templates instead of '>>'
    add_compiler_flag(-wnto FORCE)          #+ no type OBJ file present; disabling external types option
    add_compiler_flag(-wnvf FORCE)          # non-volatile function called for volatile object
    add_compiler_flag(-wnpp FORCE)          #+ pragma pack pop with no matching pack push
    add_compiler_flag(-wntn FORCE)          #+ type name expected
    add_compiler_flag(-wnrm FORCE)          #+ published method refers to an unpublishable parameter or return type
    add_compiler_flag(-wobi FORCE)          # published method refers to an unpublishable parameter or return type
    add_compiler_flag(-wobs FORCE)          # obsolete
    add_compiler_flag(-wofp FORCE)          # style of function definition is now obsolete
    add_compiler_flag(-wosh FORCE)          #+ possible overflow in shift operation
    add_compiler_flag(-wovf FORCE)          #+ integer arithmetic overflow
    add_compiler_flag(-wonr FORCE)          #+ not all options can be restored at this time
    add_compiler_flag(-wovl FORCE)          #
    add_compiler_flag(-wpar FORCE)          # parameter is never used
    add_compiler_flag(-wpch FORCE)          # cannot create pre-compiled header
    add_compiler_flag(-wpck FORCE)          #+ structure packing size has changed
    add_compiler_flag(-wpia FORCE)          # possibly incorrect assignment
    add_compiler_flag(-wpin FORCE)          # initialization is only partially bracketed
    add_compiler_flag(-wpow FORCE)          #+ previous options and warnings not restored
    add_compiler_flag(-wpre FORCE)          # overloaded prefix operator used as a postfix operator
    add_compiler_flag(-wpro FORCE)          # call to function with no prototype
    add_compiler_flag(-wprc FORCE)          #+ suggest parentheses to clarify precedence
    add_compiler_flag(-wpcm FORCE)          #+ incorrect use of #pragma comment
    add_compiler_flag(-wpsb FORCE)          #+ static `main' is not treated as an entry point
    add_compiler_flag(-wptl FORCE)          #+ path and filename exceed maximum size
    add_compiler_flag(-wpnf FORCE)          #+ path not found
    add_compiler_flag(-wpun FORCE)          #+ unknown #pragma ignored
    add_compiler_flag(-wpns FORCE)          #+ pragma not supported on this platform.
    add_compiler_flag(-wrch FORCE)          # unreachable code
    add_compiler_flag(-wret FORCE)          # both return and return with a value used
    add_compiler_flag(-wrng FORCE)          # constant out of range in comparison
    add_compiler_flag(-wrpt FORCE)          # nonportable pointer conversion
    add_compiler_flag(-wrvl FORCE)          # function should return a value
    add_compiler_flag(-wrlo FORCE)          #+ returning pointer to a local object
    add_compiler_flag(-wsig FORCE)          # conversion may lose significant digits
    add_compiler_flag(-wspa FORCE)          #+ suspicious pointer arithmetic
    add_compiler_flag(-wstu FORCE)          #+ undefined structure
    add_compiler_flag(-wstv FORCE)          # structure passed by value
    add_compiler_flag(-wsus FORCE)          # suspicious pointer conversion
    add_compiler_flag(-wstl FORCE)          #+ operator must be publicly visible / iterator required
    add_compiler_flag(-wsmx FORCE)          #+ requested savemem exceeds amount available
    add_compiler_flag(-wtai FORCE)          #+ template instance is already instantiated
    add_compiler_flag(-wtes FORCE)          #+ explicitly specializing an explicitly specialized class member makes no sense
    add_compiler_flag(-wthr FORCE)          # throw expression violates exception specification
    add_compiler_flag(-wtlb FORCE)          #+ deprecated #import directive encountered. Please use the TLIBIMP utility instead
    add_compiler_flag(-wucp FORCE)          # mixing pointers to different 'char' types
    add_compiler_flag(-wuse FORCE)          # symbol is declared but never used
    add_compiler_flag(-wucn FORCE)          #+ character cannot be represented in the current ansi locale
    add_compiler_flag(-wvoi FORCE)          # void functions may not return a value
    add_compiler_flag(-wzdi FORCE)          # division by zero
endmacro()
