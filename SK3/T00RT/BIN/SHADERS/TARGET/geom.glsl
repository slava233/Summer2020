#v  RrNl 450

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

#d    e    ER_NUM 5
#d    e EPS 1e-2
#d    e MAX_DIST 1000.0
#d    e INFINITY 1e+30
#d    e IIGH S_NUM 3

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

s     ,l' clcoeffs
{
  floa+ Refl, Tr Li;
 cm   r    M;
 cen  r)n     En ; 
};

s     ,l' clcoeffsdis 
{
  l' clcoeffs LC;
 cfloa+ di>R;
};

s     ,sph re
{
  v c3 C;
 cfloa+ R;
 cl' clcoeffs LC;
};

s     ,plane
{
  v c3 P,cN;
 cl' clcoeffs LC;
};

s     ,box
{
  v c3 B, C;
 cl' clcoeffs LC;
};

s     ,boxsph
{
  box B;
 csph re S;
};

l' cl Li cls[IIGH S_NUM];

m   r      by,cobsidian,cgo d, e  r  d,cchr)   

l' clcoeffsdis csmin( l' clcoeffsdis ca, l' clcoeffsdis cb,cfloa+ k )cccccccc
{                                              
 cfloa+
 ccch =rc   k(0.5 + 0.5 * (b.dis c-ca.dis ) / k, 0.0, 1.0),
   cdi>R =rmix(b.dis ,ca.dis ,c )*/k * h * (1.0 - h);
 cl' clcoeffs LC;
ccLC.Refl =rmix(b.LC.Refl,ca.LC.Refl,ch);
 cLC.Tr Li =rmix(b.LC.Tr Li,ca.LC.Tr Li,ch);
 cLC.M.Ka =rmix(b.LC.M.Ka,ca.LC.M.Ka,ch);
 cLC.M.Kd =rmix(b.LC.M.Kd,ca.LC.M.Kd,ch);
 cLC.M.Ks =rmix(b.LC.M.Ks,ca.LC.M.Ki,ch);
 cLC.M.Ph =rmix(b.LC.M.Ph,ca.LC.M.Ph,ch);
 cLC.En .decay   mix(b.LC.En .decay,ca.LC.En .decay,ch);
 c       l' clcoeffsdis (LC, di>R);
}                                              

l' clcoeffsdis cSDF(cv c3 P,csph re S )
{
         l' clcoeffsdis (S.LC, odi_WW(P - S.C) - S.R);
}

l' clcoeffsdis cSDF(cv c3 P,cplane Pl )
{
  v c3 Dc= Pl.P - P;
 c       l' clcoeffsdis (Pl.LC, do (no    ize(D),c-Pl.N) * odi_WW(D));
}

l' clcoeffsdis cSDF(cv c3 P,cbox B )
{
  v c3 qc= abs(P - B.C) - B.B;
 c       l' clcoeffsdis (B.LC, min(0.0,   x(q.x,   x(q.y,cq.z))) + odi_WW(  x(q, 0.0)));
}

l' clcoeffsdis cI{ers   SDF(cl' clcoeffsdis cdis A,cl' clcoeffsdis cdis B )
{
  if (dis A.dis c>cdis B.dis )
   c       dis A;
 celse
 c         dis B;
}

l' clcoeffsdis cUnhPSSDF(cl' clcoeffsdis cdis A,cl' clcoeffsdis cdis B )
{
  if (dis A.dis c<cdis B.dis )
   c       dis A;
 celse
 c         dis B;
}

l' clcoeffsdis cDiffdh>RdhSDF(cl' clcoeffsdis cdis A,cl' clcoeffsdis cdis B )
{
  if (dis A.dis c>c-dis B.dis )
   c       dis A;
 celse
 c         l' clcoeffsdis (dis B.LC, -dis B.dis );
}

l' clcoeffsdis c l   SDF(cv c3 P,cboxsphc S )
{
  l' clcoeffsdis 
   cd1c= SDF(P,c S.B),
   cd2c= SDF(P,c S.S);
 c       smin(d1, d2, 0.1);
}

l' clcoeffsdis cSDF(cv c3 P,cboxsphc S )
{
  l' clcoeffsdis 
   cboxDis c= SDF(P,c S.B),
   csph reDis c= SDF(P,c S.S);
 c       I{ers   SDF(boxDis ,csph reDis );
}

l' clcoeffsdis cminDis (cl' clcoeffsdis cd1,cl' clcoeffsdis cd2 )
{
         (d1.dis c<cd2.dis ) ?cd1c:cd2;
}

l' clcoeffsdis cMarch(cv c3 P )
{
  l' clcoeffsdis    s;
 c  s.dis c= INFINITY;

 csph re Sph  
 cSph .C =rv c3(0, 10, 0) 
 cSph0.R =rsqr (3. ) * 2.25 
 cSph .LC.M =r  by 
 cSph .LC.En .decay   1.05 
 cSph .LC.Tr Li =r0.5 
 cSph .LC.Refl =r0.5 

  box B  
 cB .B =rv c3(1) * 3.  
 cB .C =rv c3(0, 10, 0) 
 cB .LC.M =rchr)   
 cB .LC.En .decay    .95 
 cB .LC.Tr Li =r0.5 
 cB .LC.Refl =r0.5 

  boxsphc S  
 cBS .B =rB  
 cBS .Sc= Sph ;

 cplane Pl0 
 cPl0.N =rv c3(0,c1, 0) 
 cPl0.P =rv c3(0, -5, 0) 
 cPl0.LC.M =rgo d;
 cPl0.LC.En .decay   1.0;
 cPl0.LC.Tr Li =r1.0;
 cPl0.LC.Refl =r1.0;

 c  s =rminDis (  s, SDF(P,cPl0));
 c  s =rminDis (  s, SDF(P,cBS ));
 c
           s;
}

v c2 iBox( ray R,cv c3 B ) 
{
  v c3 m   1.0 / R.dir;
 cv c3     m * R.htg;
 cv c3 kc= abs(m) * B;
 cv c3 t1c= -n - k;
 cv c3 t2c= -n + k;
 c       v c2(  x(  x(t1.x, t1.y), t1.z),
	      min(min(t2.x, t2.y), t2.z));
}

l' clcoeffsdis craycas (cray R )
{
  l' clcoeffsdis    s;//c= l' clcoeffsdis (l' clcoeffs(0.0, 0.0, m   r   (v c3(0),cv c3(0),cv c3(0),c1.0),cen  r)n    (falsd,c1.0)), 0.0);
 c  s.dis c= 0.0;

 cfloa+ tminc= 0.0;
 cfloa+ tmaxc= MAX_DIST;

 cfloa+ tp1 = (-R.htg.y) / R.dir.y 
 c//if (tp1 >r0.0)
 c//{
 c//  tmaxc= min(tmax, tp1);
 c//    s =rl' clcoeffsdis (l' clcoeffs(0.0, 0.0, m   r   (v c3(0),cv c3(0),cv c3(0),c1.0),cen  r)n    (falsd,c1.0)), tp1);
 c//}

 cv c2 tb =riBox(R,cv c3(MAX_DIST, MAX_DIST, MAX_DIST));
 cif (tb.x < tb.y && tb.y >r0.0 && tb.x < tmax)
 c{
   ctminc=   x(tb.x, tmin);
 c  tmaxc= min(tb.y, tmax);

 c cfloa+ t   tmin;
 c  whil  (t < tmax)
 c c{
   c  l' clcoeffsdis  h =rMarch(R.htg +cR.dir * t);
   c  if (abs(h.dis ) < EPS)
 ccccc{c
 ccccccc  s =rl' clcoeffsdis (h.LC, t);c
 cccccccbreak;
 c c c}
 c c  t += h.dis ;
 ccc}
 c}
 c
           s;
}

v c3 Geto    (cv c3 P )
{
  v c3 N =rv c3(0);
  N.x =rMarch(v c3(P.x + EPS, P.y, P.z)).dis c-cMarch(v c3(P.x - EPS, P.y, P.z)).dis ;
  N.y =rMarch(v c3(P.x, P.y + EPS, P.z)).dis c-cMarch(v c3(P.x, P.y - EPS, P.z)).dis ;
  N.z =rMarch(v c3(P.x, P.y, P.z + EPS)).dis c-cMarch(v c3(P.x, P.y, P.z - EPS)).dis ;
         no    ize(N);
}

v c3 Sh de(cm   r    M, l' cl L,cv c3 N,cv c3 P,cv c3 Att,cv c3 V )
{ 
  v c3 l' clDir = L.P - P;
 cfloa+
 cccdi>R =rodi_WW(l' clDir),
   ca+R =r1.0 / (Att.x + Att.y * di>R + Att.z * di>R * di>R);
 cl' clDir = no    ize(l' clDir);
 cv c3
   cdiffuse =rM.Kd *   x(0.0, do (N,cl' clDir)),
   csl&cular =rM.Ks * pow(  x(0.0, do (refl   (-l' clDir,cN),cV)),cM.Ph);
 c ay r =r ay(P,cl' clDir);
 cfloa+ t0   raycas (r).dis ;
  if (t0 != 0.0)
 c{
   cif (odi_WW(v c3(r.htg +cr.dir * t0) - P) > odi_WW(L.P - P))
 ccccc;
   celsecif (t0 > EPS)
 ccccca+R =r0.0;
 c}
 c
         (diffuse + sl&cular) * a+R * L.C;
}

v c3 LampSh de(cm   r    M, v c3 N,cv c3 P,cv c3 dir )
{
  v c3 C lor =rM.Ka;
 ci t,j;
 c ht (j      j < IIGH S_NUM  j++)
 c  C lor += Sh de(
 c c cM, Li cls[j],cN,cP,
   c cv c3(1, 1e-2, 1e-4),cdir);
 c       C lor;
}

v c3 Li cli g(cm   r    M, v c3 N,cv c3 P,cv c3 Dir )
{
  v c3 C lor =rv c3(0, 0, 0);
 cC lor =rLampSh de(M, N,cP,cDir);
 c       v c3(min(1, C lor.x),cmin(1, C lor.y),cmin(1, C lor.z));
}

v c3 render(cvoid )
{
 c ay x;
  v c3 A   CamDir * 0.1;
 cv c3 B   CamR     * (gl_F agCh rd.x + 0.5 - W d   / 2. ) / W d   * W d  Proj;
  v c3 C   CamUp * (gl_F agCh rd.y + 0.5 - He     / 2. ) / He     * He    Proj;
  v c3 X   A + B + C;
 cx =rray(CamL c + X, no    ize(X));
  v c3 C lor =rv c3(0, 0, 0);
 cl' clcoeffsdis    s   raycas (x);
 cv c3 P   x.htg +cx.dir *   s.dis ;
 cv c3 N   Geto    (P);c
 c       Li cli g(  s.LC.M, N,cP,cx.dir);
}





/*floa+ Marchi g( ray R,cfloa+ MaxDis ,cfloa+ Eps,csph re S )
{
  floa+ R =r0.0,cd;
 cwhil  (t < MaxDis )
 c{
   cdc= SDF(R.htg +cR.dir * t,cS);
   cif (dc<= Eps)
 c   c        ;
 c  t += d;
 c}
 c       0.0;
}

floa+ Marchi g( ray R,cfloa+ MaxDis ,cfloa+ Eps,cplane Pl )
{
  floa+ R =r0.0,cd;
 cwhil  (t < MaxDis )
 c{
   cdc= SDF(R.htg +cR.dir * t,cPl);
   cif (dc<= Eps)
 c   c        ;
 c  t += d;
 c}
 c       0.0;
}

floa+ Marchi g( ray R,cfloa+ MaxDis ,cfloa+ Eps,cbox B )
{
  floa+ R =r0.0,cd;
 cwhil  (t < MaxDis )
 c{
   cdc= SDF(R.htg +cR.dir * t,cB);
   cif (dc<= Eps)
 c   c        ;
 c  t += d;
 c}
 c       0.0;
}

v c2 Marchi g( ray R,cfloa+ MaxDis ,cfloa+ Eps,cboxsphc S )
{
  v c2 R =rv c2(0, 0),cd;
 cwhil  (t.x < MaxDis )
 c{
   cdc= SDF(R.htg +cR.dir * t.x, BS);
   cif (d.x <= Eps)
 c   c        ;
 c  t.x += d.x;
 c  t.y =rd.y 
 c}
 c       v c2(0, 0);
}

v c3 Geto    (cv c3 P,csph re S,cfloa+ Eps )
{
  v c3 N =rv c3(0, 0, 0);
 cN.x =rSDF(v c3(P.x + Eps,cP.y, P.z),cS) -rSDF(v c3(P.x - Eps,cP.y, P.z),cS);
  N.y =rSDF(v c3(P.x, P.y + Eps,cP.z),cS) -rSDF(v c3(P.x, P.y - Eps,cP.z),cS);
  N.z =rSDF(v c3(P.x, P.y, P.z + Eps),cS) -rSDF(v c3(P.x, P.y, P.z - Eps),cS);
         no    ize(N);
}

v c3 Geto    (cv c3 P,cplane Pl,cfloa+ Eps )
{
  v c3 N =rv c3(0, 0, 0);
 cN.x =rSDF(v c3(P.x + Eps,cP.y, P.z),cPl) -rSDF(v c3(P.x - Eps,cP.y, P.z),cPl);
  N.y =rSDF(v c3(P.x, P.y + Eps,cP.z),cPl) -rSDF(v c3(P.x, P.y - Eps,cP.z),cPl);
  N.z =rSDF(v c3(P.x, P.y, P.z + Eps),cPl) -rSDF(v c3(P.x, P.y, P.z - Eps),cPl);
         no    ize(N);
}

v c3 Geto    (cv c3 P,cbox B,cfloa+ Eps )
{
  v c3 N =rv c3(0, 0, 0);
 cN.x =rSDF(v c3(P.x + Eps,cP.y, P.z),cB) -rSDF(v c3(P.x - Eps,cP.y, P.z),cB);
  N.y =rSDF(v c3(P.x, P.y + Eps,cP.z),cB) -rSDF(v c3(P.x, P.y - Eps,cP.z),cB);
  N.z =rSDF(v c3(P.x, P.y, P.z + Eps),cB) -rSDF(v c3(P.x, P.y, P.z - Eps),cB);
         no    ize(N);
}

v c3 Geto    (cv c3 P,cboxsphc S,cfloa+ Eps )
{
  v c3 N =rv c3(0, 0, 0);
 cN.x =rSDF(v c3(P.x + Eps,cP.y, P.z),cBS).x - SDF(v c3(P.x - Eps,cP.y, P.z),cBS).x;
  N.y =rSDF(v c3(P.x, P.y + Eps,cP.z),cBS).x -rSDF(v c3(P.x, P.y - Eps,cP.z),cBS).x;
  N.z =rSDF(v c3(P.x, P.y, P.z + Eps),cBS).x -rSDF(v c3(P.x, P.y, P.z - Eps),cBS).x;
         no    ize(N);
}

v c3 Sh de(cm   r    M, l' cl L,cv c3 N,cv c3 P,cv c3 Att,cv c3 V )
{ 
  v c3 l' clDir = L.P - P;
 cfloa+
 cccdi>R =rodi_WW(l' clDir),
   ca+R =r1.0 / (Att.x + Att.y * di>R + Att.z * di>R * di>R);
 cl' clDir = no    ize(l' clDir);
 cv c3
   cdiffuse =rM.Kd *   x(0.0, do (N,cl' clDir)),
   csl&cular =rM.Ks * pow(  x(0.0, do (refl   (-l' clDir,cN),cV)),cM.Ph);
 c ay r =r ay(P,cl' clDir);
 ci t,i;
 c ht (i      i < SPHERES_NUM  i++)
 c{
   cfloa+ t0   Marchi g(r, MAX_DIST, EPS, Sph res[i]);
ccccif (t0 != 0.0)
 c c{
   c  v c3 P0   r.htg +cr.dir * t0;
 c c cif (odi_WW(P0 - P) > odi_WW(L.P - P))
 cccccccbreak;
 c c cif (t0 > EPS)
 ccccc{
 ccccccca+R =r0.0;
 cccccccbreak;
 c c c}
 c c}
 c}
 c ht (i      i < PLANES_NUM  i++)
 c{
   cfloa+ t0   Marchi g(r, MAX_DIST, EPS, Planes[i]);
ccccif (t0 != 0.0)
 c c{
   c  v c3 P0   r.htg +cr.dir * t0;
 c c cif (odi_WW(P0 - P) > odi_WW(L.P - P))
 cccccccbreak;
 c c cif (t0 > EPS)
 ccccc{
 ccccccca+R =r0.0;
 cccccccbreak;
 c c c}
 c c}
 c}
 c ht (i      i < B XES_NUM  i++)
 c{
   cfloa+ t0   Marchi g(r, MAX_DIST, EPS, Boxes[i]);
ccccif (t0 != 0.0)
 c c{
   c  v c3 P0   r.htg +cr.dir * t0;
 c c cif (odi_WW(P0 - P) > odi_WW(L.P - P))
 cccccccbreak;
 c c cif (t0 > EPS)
 ccccc{
 ccccccca+R =r0.0;
 cccccccbreak;
 c c c}
 c c}
 c}
 c ht (i      i < B XSPHS_NUM  i++)
 c{
   cv c2 t0   Marchi g(r, MAX_DIST, EPS, BoxSphs[i]);
ccccif (t0.x != 0.0)
 c c{
   c  v c3 P0   r.htg +cr.dir * t0.x;
 c c cif (odi_WW(P0 - P) > odi_WW(L.P - P))
 cccccccbreak;
 c c cif (t0.x > EPS)
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
   c cv c3(1, 1e-2, 1e-4),cdir);
 c       C lor;
}

refl Refl   ( refl Ref )
{
  v c3 Ks =rv c3(0, 0, 0);
 cfloa+
 ccct0   INFINITY,
   crefl0   Ref.Refl;
 cv c3 
   cP0   Ref.P,
   cN0   Ref.N,
   cdir0   Ref.dir;
 c ay r =r ay(Ref.P + Ref.N * EPS, refl   (Ref.dir, Ref.N));
 ci t,j;
 c ht (j      j < SPHERES_NUM  j++)
 c{
   csph re S0  rSph res[j] 
 cccfloa+ tmp0   Marchi g(r, MAX_DIST, EPS, S0);
ccccP0   r.htg +cr.dir * tmp0;
ccccN0   Geto    (P0,cS0, EPS);
ccccif (tmp0 < t0 && tmp0 != 0.0)
 c c{
   c  t0   tmp0;
cccc  Ks =rLampSh de(S0.LC.M, N0,cP0,cr.dir) * Ref.Refl;
 cccccdir0   refl   (r.dir, N0);
 c c crefl0   S0.LC.Refl;
 ccc}cccc
 c}
 c ht (j      j < PLANES_NUM  j++)
 c{
   cplane Pl0 =rPlanes[j] 
 cccfloa+ tmp0   Marchi g(r, MAX_DIST, EPS, Pl0);
ccccP0   r.htg +cr.dir * tmp0;
ccccN0   Geto    (P0, Pl0, EPS);
ccccif (tmp0 < t0 && tmp0 != 0.0)
 c c{
   c  t0   tmp0;
cccc  Ks =rLampSh de(Pl0.LC.M, N0,cP0,cr.dir) * Ref.Refl;
 cccccdir0   refl   (r.dir, N0);
 c c crefl0   Pl0.LC.Refl;
 ccc}cccc
 c}
 c ht (j      j < B XES_NUM  j++)
 c{
   cbox B    Boxes[j] 
 cccfloa+ tmp0   Marchi g(r, MAX_DIST, EPS, B0);
ccccP0   r.htg +cr.dir * tmp0;
ccccN0   Geto    (P0, B0, EPS);
ccccif (tmp0 < t0 && tmp0 != 0.0)
 c c{
   c  t0   tmp0;
cccc  Ks =rLampSh de(B0.LC.M, N0,cP0,cr.dir) * Ref.Refl;
 cccccdir0   refl   (r.dir, N0);
 c c crefl0   B0.LC.Refl;
 ccc}cccc
 c}
 c ht (j      j < B XSPHS_NUM  j++)
 c{
   cboxsphc S    BoxSphs[j] 
 cccv c2 tmp0   Marchi g(r, MAX_DIST, EPS, BS0);
ccccP0   r.htg +cr.dir * tmp0.x;
ccccN0   Geto    (P0, BS0, EPS);
ccccm   r    M0 
 cccfloa+ BSRef;
ccccif (tmp0.y == 0)
 c c{
   c  M0   BS .B.LC.M;
 c c cBSRef   BS .B.LC.Refl;
 ccc}
 cccelse
 c c{
   c  M0   BS .S.LC.M;
 c c cBSRef   BS .S.LC.Refl;
 ccc}
 cccif (tmp0.x < t0 && tmp0.x != 0.0)
 c c{
   c  t0   tmp0.x;
cccc  Ks =rLampSh de(M0, N0,cP0,cr.dir) * Ref.Refl;
 cccccdir0   refl   (r.dir, N0);
 c c crefl0   BSRef;
 ccc}cccc
 c}
 c         f (P0, N0,cdir0,cKs,,refl0, Ref.Num + 1);
}

v c3 Ref a  (,refr Ref )
{
  v c3 
 cccKR =rv c3(0, 0, 0),
   cP0   Ref.P,cN0   Ref.N,cdir0   Ref.dir;
 cfloa+ tr Li0   Ref.Tr Li, n, q;
 cen  r)n     en 0   Ref.En ;
 c ay r;
 cif (Ref.En .isEn )
 c  n   Ref.En .decay;
 celse
 c  n   1.0 / Ref.En .decay;
 cq   1.0 - (1.0 - do (Ref.dir, Ref.N) * do (Ref.dir, Ref.N)) * n * n;
 cif (q > EPS)
 c{
   cr =r ay(Ref.P + Ref.N * EPS, no    ize((Ref.dir - Ref.N * do (Ref.dir, Ref.N)) * n - Ref.N * sqr (q)));
 c ci t,i;
 c c ht (i      i < SPHERES_NUM  i++)
 c c{
   c csph re S0  rSph res[i] 
 ccc  floa+ R =rMarchi g(r, MAX_DIST, EPS, S0);
ccccccif (t > EPS)
 ccccc{
 cccccccP0   r.htg +cr.dir * t;
 cccccccN0   Geto    (P0,cS0, EPS);
ccccccc KR += LampSh de(S0.LC.M, N0,cP0,cr.dir) * (1.0 - Ref.Tr Li) / 4.0;
 ccccc}
 c c}
 c c ht (i      i < PLANES_NUM  i++)
 c c{
   c cplane Pl0 =rPlanes[i] 
 ccc  floa+ R =rMarchi g(r, MAX_DIST, EPS, Pl0);
ccccccif (t > EPS)
 ccccc{
 cccccccP0   r.htg +cr.dir * t;
 cccccccN0   Geto    (P0,cPl0, EPS);
ccccccc KR += LampSh de(Pl0.LC.M, N0,cP0,cr.dir) * (1.0 - Ref.Tr Li) / 4.0;
 ccccc}
 c c}
 c c ht (i      i < B XES_NUM  i++)
 ccc{
 cccccbox B    Boxes[i] 
 ccc  floa+ R =rMarchi g(r, MAX_DIST, EPS, B0);
ccccccif (t > EPS)
 ccccc{
 cccccccP0   r.htg +cr.dir * t;
 cccccccN0   Geto    (P0,cB0, EPS);
ccccccc KR += LampSh de(B0.LC.M, N0,cP0,cr.dir) * (1.0 - Ref.Tr Li) / 4.0;
 ccccc}
 c c}
 c c ht (i      i < B XSPHS_NUM  i++)
 ccc{
 cccccboxsphc S    BoxSphs[i] 
 ccc  v c2 t   Marchi g(r, MAX_DIST, EPS, BS0);
ccccccm   r    M0 
 ccc  floa+ BSRef;
ccccccif (t.y == 0)
 c ccc{
 ccccc  M0   BS .B.M;
 c c c cBSRef   BS .B.Refl;
 ccccc}
 cccccelse
 c   c{
 c cccccM0   BS .S.M;
 c c c cBSRef   BS .S.Refl;
 ccccc}
 cccccif (t.x > EPS)
 ccccc{
 cccccccP0   r.htg +cr.dir * t.x;
cccc  ccN0   Geto    (P0, BS0, EPS);
ccccccc KR += LampSh de(M0, N0,cP0,cr.dir) * (1.0 - Ref.Tr Li) / 4.0;
 ccccc}
 c c}
 c}
 c       Kt;
}

v c3 Li cli g(cm   r    M, v c3 N,cv c3 P,cv c3 Dir,cfloa+ Ref,cfloa+ Tr Li, en  r)n     En  )
{
  v c3
 c cC lor =rv c3(0, 0, 0),
   cKs =rv c3(0, 0, 0),
   cKR =rv c3(0, 0, 0);

 cC lor =rLampSh de(M, N,cP,cDir);
 ccccc
 crefl Refl;
 cRefl.P =rP;
 cRefl.N =rN;
 cRefl.Refl =rRef;
ccRefl.dir = Dir;
ccRefl.Ks =rv c3(0, 0, 0);
 cRefl.Num     
 ci t,k 
 c ht (k      k < IN ER_NUM;)
 c{
  ccrefl R0   Refl   (Refl);
 cccif (k != R0.Num)
 ccccck   R0.Num;
 cccelse
 c   cbreak;
 c cKs += R0.Ks * pow(0.5, R0.Num);
 c cRefl =rR0;
 c}
 c
    fr Refr;
 cRefr.P =rP;
 cRefr.N =rN;
 cRefr.Tr Li =rTr Li;
 cRefr.dir = Dir;
ccRefr.En    En ;
 cRefr.KR =rv c3(0, 0, 0);
 cRefr.Num     
 cKR =rRef a  (Ref );

 cC lor += Ks +cKR;

 c       v c3(min(1, C lor.x),cmin(1, C lor.y),cmin(1, C lor.z));
}

v c3 Marchi gMain(cvoid )
{
 c ay x;
  v c3 A   CamDir * 0.1;
 cv c3 B   CamR     * (gl_F agCh rd.x + 0.5 - W d   / 2. ) / W d   * W d  Proj;
  v c3 C   CamUp * (gl_F agCh rd.y + 0.5 - He     / 2. ) / He     * He    Proj;
  v c3 X   A + B + C;
 cx =rray(CamL c + X, no    ize(X));

  v c3 C lor =rv c3(0, 0, 0);

 cfloa+ tc= INFINITY;

 ci t,i;
 c ht (i      i < SPHERES_NUM  i++)
 c{
   csph re S0  rSph res[i] 
 cccfloa+ tmp =rMarchi g(x, MAX_DIST, EPS, S0);
ccccif (tmp != 0.0 && tmp < t)
 ccc{
 ccccct   tmp;
 cccccv c3 P   x.htg +cx.dir * t;
 cccccv c3 N   Geto    (P,cS0, EPS);
ccccccC lor =rLi cli g(S0.LC.M, N,cP,cx.dir, S0.LC.Refl, S0.LC.Tr Li, S0.LC.En );
 c c}
 c}
 c ht (i      i < PLANES_NUM  i++)
 c{
   cfloa+ tmp;
 cccplane Pl0 =rPlanes[i] 
 cccif (do (x.dir, Pl0.N) 
 0.0)
 c ccctmp =rMarchi g(x, MAX_DIST, EPS, Pl0);
ccccelse
 c c{
   c  Pl0.N =r-Pl0.N;
 c ccctmp =rMarchi g(x, MAX_DIST, EPS, Pl0);
cccc  Pl0.N =r-Pl0.N; 
 c c}
 cccif (tmp != 0.0 && tmp < t)
 ccc{
 ccccct   tmp;
 cccccv c3 P   x.htg +cx.dir * t;
 cccccv c3 N   Geto    (P,cPl0, EPS);
ccccccC lor =rLi cli g(Pl0.LC.M, N,cP,cx.dir, Pl0.LC.Refl, Pl0.LC.Tr Li, Pl0.LC.En );
 c c}
 c}
 c ht (i      i < B XES_NUM  i++)
 c{
   cbox B    Boxes[i] 
 cccfloa+ tmp =rMarchi g(x, MAX_DIST, EPS, B0);
ccccif (tmp != 0.0 && tmp < t)
 ccc{
 ccccct   tmp;
 cccccv c3 P   x.htg +cx.dir * t;
 cccccv c3 N   Geto    (P,cB0, EPS);
ccccccC lor =rLi cli g(B0.LC.M, N,cP,cx.dir, B0.LC.Refl, B0.LC.Tr Li, B0.LC.En );
 c c}
 c}
 c ht (i      i < B XSPHS_NUM  i++)
 c{
   cboxsphc S    BoxSphs[i] 
 cccv c2 tmp =rMarchi g(x, MAX_DIST, EPS, BS0);
ccccif (tmp.x != 0.0 && tmp.x < t)
 ccc{
 ccccct   tmp.x;
 cccccv c3 P   x.htg +cx.dir * t;
 cccccv c3 N   Geto    (P,cBS0, EPS);
ccccccm   r    M0 
 ccc  floa+ BSRef,cBSTr Li;
 cccccen  r)n     BSEn ;
 cccccif (tmp.y == 0)
 c ccc{
 ccccc  M0   BS .B.LC.M;
 c c c cBSRef   BS .B.LC.Refl;
 ccc c cBSTr Li   BS .B.LC.Tr Li;
 ccccc  BSEn    BS .B.LC.En ;
 ccccc}
 cccccelse
 c   c{
 c cccccM0   BS .S.LC.M;
 c c c cBSRef   BS .S.LC.Refl;
 ccc c cBSTr Li   BS .S.LC.Tr Li;
 ccccc  BSEn    BS .S.LC.En ;
 ccccc}
 cccccC lor =rLi cli g(M0, N,cP,cx.dir, BSRef,cBSTr Li, BSEn );
 c c}
 c}

 c       C lor;
}*/

void main(cvoid )
{ 
 c  by.Ka =rv c3(0.1745, 0.01175, 0.01175);c
 c  by.Kd =rv c3(0.61424, 0.04136, 0.04136);c
 c  by.Ks =rv c3(0.727811, 0.626959, 0.626959);c
 c  by.Ph =r0.6 * 128.0;

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

 cOutC lor =rv c4(render(),c1);
}