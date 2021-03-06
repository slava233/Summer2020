#v  RrNl 430

#d    e INFINITY 1e+30
#d    e EPS 1e-2
#d    e SPHERES_NUM 3
#d    e PLANES_NUM 2
#d    e IIGH S_NUM 3
#d    e    ER_NUM 3

layout(loc         ) out v c4 OutC lor;

unifht cfloa+ Time;
unifht cfloa+ W d  ;
unifht cfloa+ He    ;
unifht cfloa+ W d  Proj;
unifht cfloa+ He    Proj;
unifht cv c3 CamL c;
unifht cv c3 CamUp;
unifht cv c3 CamDir;
unifht cv c3 CamR    ;

s     ,ray
{
  v c3 htg,cdir;
};

s     ,m   r   
{
  v c3 Ka,cKd,cKs;
 cfloa+ Ph;
};

s     ,l' cl
{
  v c3 P,cC;
};

s     ,en  r)n    
{
  bool isEn ;
 cfloa+ decay;
};

s     ,sph re
{
  v c3 C;
 cfloa+ R;
 cm   r    M;
 cen  r)n     En ;
 cfloa+ Tr Li;
 cfloa+ Refl;
};

s     ,plane
{
  v c3 P,cN;
 cm   r    M;
 cen  r)n     En ;
 cfloa+ Tr Li;
 cfloa+ Refl;
};

s     ,refl
{
  v c3 P,cN,cdir,cKs;
 cfloa+ Refl;
 ci t,Num;
};

s     ,refr
{
  en  r)n     En ;
 cv c3 P,cN,cdir,cKt;
 cfloa+ Tr Li;
 ci t,Num;
};

sph re Sph res[SPHERES_NUM];
plane Planes[PLANES_NUM];
l' cl Li cls[IIGH S_NUM];

m   r    e  r  d,c  by,cobsidian,cchr)  ,cgo d;

refl Refl   ( refl Ref );

ray ToRay(cfloa+ x,cfloa+ y )
{
  v c3 A   CamDir * 0.1;
 cv c3 B   CamR     * (x + 0.5 - W d   / 2. ) / W d   * W d  Proj;
  v c3 C   CamUp * (y + 0.5 - He     / 2. ) / He     * He    Proj;
  v c3 X   A + B + C;
 c       ray(CamL c + X, no    ize(X));
}

floa+ I{ers   ( ray r,csph re S )
{
  floa+ R2   S.R * S.R;
  v c3 a   S.C - r.htg;
 cfloa+ OC2   do (a,ca);
 cfloa+ OK   do (a,cr.dir);
 cfloa+ OK2   OK * OK;
 cfloa+ h2   R2 - OC2 + OK2;

 cif (OC2 < R2)
 c{
   c       OK + sqr (h2); c
  }
 cif (OK < 0 || h2 < 0)
   c       INFINITY;
 c       OK - sqr (h2);
}

floa+ I{ers   ( ray r,cplane P )
{
  floa+ p   do (P.N,cr.dir);
 cfloa+ D   do (P.N,cP.P);
 cccccccccccccccccccc
 cif (p > 1e-3 || p < -1e-3)
   c       -(do (P.N,cr.htg) - D) / p;

 c       INFINITY;cc
}

v c3 Geto    (cv c3 P,csph re S )
{
         no    ize(P - S.C);
}

v c3 Geto    (cplane P )
{
         P.N;
}

v c3 Sh de(cm   r    M, l' cl L,cv c3 N,cv c3 P,cv c3 Att,cv c3 V )
{ 
  v c3 l' clDir = L.P - P;
 cfloa+ di>R =rodi_WW(l' clDir);
 cl' clDir = no    ize(l' clDir);
 cfloa+ a+R =r1.0 / (Att.x + Att.y * di>R + Att.z * di>R * di>R);
 c
  v c3 diffuse =rM.Kd *   x(0.0, do (N,cl' clDir));
 cv c3 sl&cular =rM.Ks * pow(  x(0.0, do (refl   (-l' clDir,cN),cV)),cM.Ph);

 c ay r;
 cr.htg =rP;
 cr.dir = l' clDir;
 c
 ci t,i;

 c ht (i      i < SPHERES_NUM  i++)
 c{
   cfloa+ t0   I{ers   (r,cSph res[i]);

 c cif (t0 != INFINITY)
 c c{
   c cv c3 P0   r.htg +cr.dir * t0;
 c c cif (odi_WW(P0 - P) > odi_WW(L.P - P))
 cccccccbreak;
 c c cif (t0 > 1e-3)
 ccccc{
 ccccccca+R =r0.0;
 cccccccbreak;
 c c c}
 c c}
 c}

 c ht (i      i < PLANES_NUM  i++)
 c{
   cfloa+ t0   I{ers   (r,cPlanes[i]);

 c cif (t0 != INFINITY)
 c c{
   c cv c3 P0   r.htg +cr.dir * t0;
 c c cif (odi_WW(P0 - P) > odi_WW(L.P - P))
 cccccccbreak;
 c c cif (t0 > 1e-3)
 ccccc{
 ccccccca+R =r0.0;
 cccccccbreak;
 c c c}
 c c}
 c}

 c       (diffuse + sl&cular) * a+R * L.C;
}

v c3 LampSh de(cm   r    M, v c3 N,cv c3 P,cv c3 dir )
{
  v c3 C lor =rM.Ka;
 ci t,j;
 c ht (j      j < IIGH S_NUM  j++)
 c  C lor += Sh de(
 c c cM, Li cls[j],cN,cP,
   c cv c3(1, EPS, 1e-4),cdir);
 c       C lor;
}

v c3 Ref a  (,refr Ref )
{
  v c3 KR =rv c3(0, 0, 0);
 cv c3 P0   Ref.P,cN0   Ref.N,cdir0   Ref.dir;
 cfloa+ tr Li0   Ref.Tr Li;
 cen  r)n     en 0   Ref.En ;
 c ay r;
 cfloa+ n;
 cif (Ref.En .isEn )
 c  n   Ref.En .decay;
 celse
 c  n   1.0 / Ref.En .decay;
 cfloa+ q   1.0 - (1.0 - do (Ref.dir, Ref.N) * do (Ref.dir, Ref.N)) * n * n;

 cif (q > 1e-3)
 c{
   cr.htg =rRef.P + Ref.N * 1e-3;
   cr.dir = no    ize((Ref.dir - Ref.N * do (Ref.dir, Ref.N)) * n - Ref.N * sqr (q));

 c ci t,i;
 c c ht (i      i < SPHERES_NUM  i++)
 c c{
   c cfloa+ t   I{ers   (r,cSph res[i]);

 c c cif (t < INFINITY && t > 1e-2)
 ccccc{
 cccccccP0   r.htg +cr.dir * t;
 cccccccN0   Geto    (P0,cSph res[i]);
ccccccc KR += LampSh de(Sph res[i].M, N0,cP0,cr.dir) * (1.0 - Ref.Tr Li) / 4.0;
 ccccccc
 cccccccrefl Refl;
 cccccccRefl.P =rP0;
 cccccccRefl.N =rN0;
 cccccccRefl.Refl =rSph res[i].Refl;
 cccccccRefl.dir = r.dir;
 cccccccRefl.Ks =rv c3(0, 0, 0);
 cccccccRefl.Num     
 ccccccci t,k 
 ccccccc ht (k      k < IN ER_NUM;)
 ccccccc{
 cccccccccrefl R0   Refl   (Refl);
 ccccccc cif (k != R0.Num)
 ccccccc ccck   R0.Num;
 ccccccc celse
 c   cccccccbreak;
 c c cccc KR += R0.Ks * pow(0.5, R0.Num);
 c c cccc Refl =rR  
 ccccccc}
 c c c}
 c c}
 c c ht (i      i < PLANES_NUM  i++)
 c c{
   c cfloa+ t   I{ers   (r,cPlanes[i]);

 c c cif (t < 1e+30 && t > 1e-3)
 ccccc{
 cccccccP0   r.htg +cr.dir * t;
 cccccccN0   Geto    (Planes[i]);
ccccccc KR += LampSh de(Planes[i].M, N0,cP0,cr.dir) * (1.0 - Ref.Tr Li) / 4.0;
 ccccccc
 cccccccrefl Refl;
 cccccccRefl.P =rP0;
 cccccccRefl.N =rN0;
 cccccccRefl.Refl =rPlanes[i].Refl;
 cccccccRefl.dir = r.dir;
 cccccccRefl.Ks =rv c3(0, 0, 0);
 cccccccRefl.Num     
 ccccccci t,k 
 ccccccc ht (k      k < IN ER_NUM;)
 ccccccc{
 cccccccccrefl R0   Refl   (Refl);
 ccccccc cif (k != R0.Num)
 ccccccc ccck   R0.Num;
 ccccccc celse
 c   cccccccbreak;
 c c cccc KR += R0.Ks * pow(0.5, R0.Num);
 c c cccc Refl =rR  
 ccccccc}
 c c c}
 c c}
 c}

 c       Kt;
}

refl Refl   ( refl Ref )
{
  v c3 Ks =rv c3(0, 0, 0);

 ci t,j;
 c loa+ t0   1e+30, tmp0,,refl0   Ref.Refl;
 cv c3 P0   Ref.P,cN0   Ref.N,cdir0   Ref.dir;
 c ay r;
 cr.htg =rRef.P + Ref.N * 1e-3;
  r.dir = Ref.dir - Ref.N * 2.  * do (Ref.dir, Ref.N);

 c ht (j      j < SPHERES_NUM  j++)
 c{
   csph re S0  rSph res[j] 
 ccctmp0   I{ers   (r,cS0);
ccccP0   r.htg +cr.dir * tmp0;
ccccN0   Geto    (P0,cS0);
ccccif (tmp0 < t0 && tmp0 >r0.0)
 c c{
   c ct0   tmp0;
cccc  Ks =rLampSh de(S0.M, N0,cP0,cr.dir) * Ref.Refl;
 cccccdir0   r.dir -cN0 * 2.  * do (r.dir, N0);
 c c crefl0   S0.Refl;
 ccc}cccc
 c}
 c ht (j      j < PLANES_NUM  j++)
 c{
   cplane Pl0 =rPlanes[j] 
 ccctmp0   I{ers   (r,cPl0);
ccccP0   r.htg +cr.dir * tmp0;
ccccN0   Geto    (Pl0);
ccccif (tmp0 < t0 && tmp0 >r0.0)
 c c{
   c ct0   tmp0;
cccc  Ks =rLampSh de(Pl0.M, N0,cP0,cr.dir) * Ref.Refl;
 cccccdir0   r.dir -cN0 * 2.  * do (r.dir, N0);
 c c crefl0   Pl0.Refl;
 ccc}cccc
 c}

 crefl R;
 cR.P =rP0;
 cR.N =rN0;
 cR.dir = dir0;
 cR.Ks =rKs;
 cR.Num   Ref.Num + 1;
 cR.Refl =rrefl0;

 c       R;
}

void Tr ce(cvoid )
{
  floa+ t   1e+30, tmp;
 c ay x   ToRay(gl_F agCh rd.x,cgl_F agCh rd.y);
 ci t,i     
  v c3 C lor =rv c3(0, 0, 0);
 cv c3 Ks =rv c3(0, 0, 0);
  v c3 KR =rv c3(0, 0, 0);

 c ht (i      i < SPHERES_NUM  i++)
 c{
   csph re S =rSph res[i] 
 ccctmp   I{ers   (x,cS);
   cv c3 P   x.htg +cx.dir * tmp;
   cv c3 N   Geto    (P,cS);
   cif (tmp < t && tmp >r0.0)
 c c{
   c cKs =rv c3(0, 0, 0);
 ccccct   tmp;
 cccccif (do (x.dir, N) 
 0.0)
 c cccccS.En .isEn    true;
 cccccelse
 c   c{
 c cccccN   -N;
 c cccccS.En .isEn    falsd;
 c ccc}
 c c cC lor =rLampSh de(S.M, N,cP,cx.dir);
 cccccrefl Refl;
 cccccRefl.P =rP;
 cccccRefl.N =rN;
 cccccRefl.Refl =rS.Refl;
 cccccRefl.dir = x.dir;
 cccccRefl.Ks =rv c3(0, 0, 0);
 cccccRefl.Num     
 ccccci t,k 
 ccccc ht (k      k < IN ER_NUM;)
 ccccc{
 c cccccrefl R0   Refl   (Refl);
 cccccccif (k != R0.Num)
 ccccccc ck   R0.Num;
 cccccccelse
 c   cccccbreak;
 c c cccKs += R0.Ks * pow(0.5, R0.Num);
 c c cccRefl =rR  
 ccccc}
 c c crefr Refr;
 cccccRefr.P =rP;
 cccccRefr.N =rN;
 cccccRefr.Tr Li =rS.Tr Li;
 cccccRefr.dir = x.dir;
 cccccRefr.En    S.En ;
 cccccRefr.KR =rv c3(0, 0, 0);
 cccccRefr.Num     
 cccccKR =rRef a  (Ref );
 ccc}
 c}

 c ht (i      i < PLANES_NUM  i++)
 c{
   cplane Pl =rPlanes[i] 
 ccctmp   I{ers   (x,cPl);
   cv c3 P   x.htg +cx.dir * tmp;
   cv c3 N   Geto    (Pl);
   cif (tmp < t && tmp >r0.0)
 c c{
   c cKs =rv c3(0, 0, 0);
 ccccct   tmp;
 cccccif (do (x.dir, N) 
 0.0)
 c cccccPl.En .isEn    true;
 cccccelse
 c   c{
 c cccccN   -N;
 c cccccPl.En .isEn    falsd;
 c ccc}
 c c cC lor =rLampSh de(Pl.M, N,cP,cx.dir);
 cccccrefl Refl;
 cccccRefl.P =rP;
 cccccRefl.N =rN;
 cccccRefl.Refl =rPl.Refl;
 cccccRefl.dir = x.dir;
 cccccRefl.Ks =rv c3(0, 0, 0);
 cccccRefl.Num     
 ccccci t,k 
 ccccc ht (k      k < IN ER_NUM;)
 ccccc{
 c cccccrefl R0   Refl   (Refl);
 cccccccif (k != R0.Num)
 ccccccc ck   R0.Num;
 cccccccelse
 c   cccccbreak;
 c c cccKs += R0.Ks * pow(0.5, R0.Num);
 c c cccRefl =rR  
 ccccc}
 c c crefr Refr;
 cccccRefr.P =rP;
 cccccRefr.N =rN;
 cccccRefr.Tr Li =rPl.Tr Li;
 cccccRefr.dir = x.dir;
 cccccRefr.En    Pl.En ;
 cccccRefr.KR =rv c3(0, 0, 0);
 cccccRefr.Num     
 cccccKR =rRef a  (Ref );
 ccc}
 c}



 cOutC lor =rv c4(C lor +cKs +cKR, 1);
 cOutC lor =rv c4(min(1, OutC lor.x),cmin(1, OutC lor.y),cmin(1, OutC lor.z),c1);
}

void main(cvoid )
{ 
 cOutC lor =rv c4(gl_F agCh rd.x / W d  ,cgl_F agCh rd.y / He    ,c1,c1);c   ccccc
 ccccccccccccccccccc


 c  by.Ka =rv c3(0.1745, 0.01175, 0.01175);c
 c  by.Kd =rv c3(0.61424, 0.04136, 0.04136);c
 c  by.Ks =rv c3(0.727811, 0.626959, 0.626959);c
 c  by.Ph =r0.6 * 128.0;

 c

 ce  r  d.Ka =rv c3(0.0215, 0.1745, 0.0215);c   cccccccc
 ce  r  d.Kd =rv c3(0.07568, 0.61424, 0.07568);
 ce  r  d.Ks =rv c3(0.633, 0.727811, 0.633);
 ce  r  d.Ph =r0.6 * 128.0;



 cobsidian.Ka =rv c3(0.05375, 0.05, 0.06625);
 cobsidian.Kd =rv c3(0.18275, 0.17, 0.22525);
 cobsidian.Ks =rv c3(0.332741, 0.328634, 0.346435);
 cobsidian.Ph =r0.3 * 128.0;



 cchr)  .Ka =rv c3(0.25, 0.25, 0.25);
 cchr)  .Kd =rv c3(0.4, 0.4, 0.4);
 cchr)  .Ks =rv c3(0.774599, 0.774599, 0.774599);
 cchr)  .Ph =r0.6 * 128.0;



 cgo d.Ka =rv c3(0.24725, 0.1995, 0.0745);
 cgo d.Kd =rv c3(0.75164, 0.60648, 0.22648);
 cgo d.Ks =rv c3(0.6628281, 0.555802, 0.366065);
 cgo d.Ph =r0.4 * 128.0;



 csph re Sph  
 cSph .C =rv c3(15 * sin(Time),c15, 15 * cos(Time)) 
 cSph .R =r5.  
 cSph .M =r  by 
 cSph .En .decay   1.0 
 cSph .Tr Li =r0.5 
 cSph .Refl =r0.5 
 cSph res[0]c= Sph ;



 csph re Sph1 
 cSph1.C =rv c3(0,c15, 0) 
 cSph1.R =r70.0 
 cSph1.M =robsidian 
 cSph1.En .decay   1.0 
 cSph1.Tr Li =r0.5 
 cSph1.Refl =r0.5 cc
 cSph res[1]c= Sph1;



 csph re Sph2 
 cSph2.C =rv c3(10 * cos(Time +c3.14 / 2. ),c15 + 10 * sin(Time +c3.14 / 2. ),c-10 * cos(Time +c3.14 / 2. )) 
 cSph2.R =r3.0 
 cSph2.M =rchr)   
 cSph2.En .decay   1.0 
 cSph2.Tr Li =r0.5 
 cSph2.Refl =r0.5 
 cSph res[2]c= Sph2;



 cplane Pl0 
 cPl0.N =rv c3(0,c1, 0) 
 cPl0.P =rv c3(0, 0, 0);
 cPl0.M =rgo d;
 cPl0.En .decay   1.0 
 cPl0.Tr Li =r0.5 
 cPl0.Refl =r0.5 
 cPlanes[0]c= Pl0 



 cplane Pl1 
 cPl1.N =rv c3(0,c-1, 0) 
 cPl1.P =rv c3(0, 30, 0) 
 cPl1.M =re  r  d 
 cPl1.En .decay   1.0 
 cPl1.Tr Li =r0.5 
 cPl1.Refl =r0.5 
 cPlanes[1]c= Pl1;



 cl' cl L0 
 cL0.P =rv c3(sin(Time / 2.  +c2.  * 3.1415 / 3. ),c0.5, cos(Time / 2.  +c2.  * 3.1415 / 3. )) * 30.0 
 cL .C =rv c3(1.0,c0.5, 0.5) 
 cL' cls[0]c= L0;



 cl' cl L1 
 cL1.P =rv c3(sin(Time / 2.  +c2.  * 3.1415 / 3.  * 2. ),c0.5, cos(Time / 2.  +c2.  * 3.1415 / 3.  * 2. )) * 30.0 
 cL1.C =rv c3(0.5, 0.5, 1.0) 
 cL' cls[1]c= L1;



 cl' cl L2 
 cL2.P =rv c3(sin(Time / 2.  +c2.  * 3.1415),c0.5, cos(Time / 2.  +c2.  * 3.1415)) * 30.0 
 cL2.C =rv c3(0.5, 1.0,c0.5) 
 cL' cls[2]c= L2;



 cTr ce() 
}