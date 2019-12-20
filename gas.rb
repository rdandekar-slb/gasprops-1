class Gas
    attr_reader :name, :spgr, :co2, :h2s, :n2, :zfactor_g, :b_g, :rho_g
    

    def initialize(name="New Gas",spgr=0.65,co2=nil,h2s=nil,n2=nil)
        @name = name
        @spgr = spgr
        @co2 = co2 == nil ? 0.0 : co2 / 100.0
        @h2s = h2s == nil ? 0.0 : h2s / 100.0
        @n2  = n2  == nil ? 0.0 : n2 / 100.0
    end

    def calculate_properties(press, temp)
        r = 10.73 #gas constant
        a1 = 0.3265
        a2 = -1.07
        a3 = -0.5339
        a4 = 0.01569
        a5 = -0.05165
        a6 = 0.5475
        a7 = -0.7361
        a8 = 0.1844
        a9 = 0.1056
        a10 = 0.6134
        a11 = 0.721
      
        epsilon = (120.0 * ((@h2s + @co2)**0.9 - (@h2s + @co2)**1.6)) 
        epsilon += (15.0 * (@h2s**0.5 - @h2s**4))
        ppc = 756.8 - (131.0 * @spgr) - (3.6 * @spgr * @spgr)
        tpc = 169.2 + (349.5 * @spgr) - (74.0 * @spgr * @spgr)
        
        tpc -= epsilon
        ppc = ppc * tpc / (tpc + @h2s * (1 - @h2s) * epsilon)
        ppr = press / ppc
        tpr = (temp + 459.67) / tpc

        z_temp=1
        while true
            rhopr=0.27*(ppr/(z_temp*tpr))
            c1=a1+(a2/tpr)+(a3/tpr**3)+(a4/tpr**4)+(a5/tpr**5)
            c2=a6+(a7/tpr)+(a8/tpr**2)
            c3=a9*((a7/tpr)+(a8/tpr**2))
            c4=a10*(1+a11*rhopr**2)*((rhopr**2/tpr**3)*Math.exp(-a11*rhopr**2))

            fz=z_temp - (1+ c1*rhopr + c2*rhopr**2 - c3*rhopr**5 + c4)
            dfz= 1 + (c1*rhopr/z_temp) + (2*c2*rhopr**2/z_temp) - (5*c3*rhopr**5/z_temp)+ (2 * (a10*rhopr**2) * ((1 + a11*rhopr**2-(a11*rhopr**2)**2) / (tpr**3 * z_temp)) * Math.exp(-a11 * rhopr ** 2))
            z_new = z_temp - fz/dfz
            if (z_new-z_temp)<0.000001
                break
            else
                z_temp=z_new
            end
        end 
        @zfactor_g=z_new
        @b_g = 0.02827*@zfactor_g*(temp+459.67)/press
        @rho_g = 28.9586*@spgr*press/(r * @zfactor_g * (temp+459.67))
        x = 3.5 + (986/(temp+459.67)) + 0.01*@spgr*28.9586
    end
end

