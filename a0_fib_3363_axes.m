function a0_fib = a0_fib_3363_axes(in1,in2,in3,in4,L,H,W,xi,eta,zeta)
%A0_FIB_3363_AXES
%    A0_FIB = A0_FIB_3363_AXES(IN1,IN2,IN3,IN4,L,H,W,XI,ETA,ZETA)

%    This function was generated by the Symbolic Math Toolbox version 8.3.
%    14-Jul-2022 15:02:00

Phi1 = in4(1,:);
Phi2 = in4(2,:);
Phi3 = in4(3,:);
a1 = in3(1,:);
a2 = in3(2,:);
a3 = in3(3,:);
ee0_pos1 = in1(1,:);
ee0_pos2 = in1(2,:);
ee0_pos3 = in1(3,:);
ee0_pos4 = in1(4,:);
ee0_pos5 = in1(5,:);
ee0_pos6 = in1(6,:);
ee0_pos7 = in1(7,:);
ee0_pos8 = in1(8,:);
ee0_pos9 = in1(9,:);
phi1 = in2(1,:);
phi2 = in2(2,:);
phi3 = in2(3,:);
t2 = abs(L);
t3 = xi+1.0;
t4 = xi.^2;
t5 = ee0_pos4.*xi.*2.0;
t6 = ee0_pos5.*xi.*2.0;
t7 = ee0_pos6.*xi.*2.0;
t8 = 1.0./H;
t9 = 1.0./L;
t10 = 1.0./W;
t11 = xi-1.0;
t17 = (ee0_pos1.*xi)./2.0;
t18 = (ee0_pos2.*xi)./2.0;
t19 = (ee0_pos3.*xi)./2.0;
t20 = (ee0_pos7.*xi)./2.0;
t21 = (ee0_pos8.*xi)./2.0;
t22 = (ee0_pos9.*xi)./2.0;
t23 = (Phi1.*pi)./1.8e+2;
t24 = (Phi2.*pi)./1.8e+2;
t25 = (Phi3.*pi)./1.8e+2;
t26 = (phi1.*pi)./1.8e+2;
t27 = (phi2.*pi)./1.8e+2;
t28 = (phi3.*pi)./1.8e+2;
t12 = 1.0./t2.^2;
t13 = -t5;
t14 = -t6;
t15 = -t7;
t16 = t4-1.0;
t29 = (ee0_pos7.*t3)./2.0;
t30 = (ee0_pos8.*t3)./2.0;
t31 = (ee0_pos9.*t3)./2.0;
t32 = cos(t23);
t33 = cos(t24);
t34 = cos(t25);
t35 = sin(t23);
t36 = sin(t24);
t37 = sin(t25);
t38 = cos(t26);
t39 = cos(t27);
t40 = cos(t28);
t41 = sin(t26);
t42 = sin(t27);
t43 = sin(t28);
t44 = (ee0_pos1.*t11)./2.0;
t45 = (ee0_pos2.*t11)./2.0;
t46 = (ee0_pos3.*t11)./2.0;
t47 = t32.*t38;
t48 = t33.*t39;
t49 = t34.*t40;
t50 = t32.*t41;
t51 = t35.*t38;
t52 = t33.*t42;
t53 = t36.*t39;
t54 = t34.*t43;
t55 = t37.*t40;
t56 = t35.*t41;
t57 = t36.*t42;
t58 = t37.*t43;
t62 = t13+t17+t20+t29+t44;
t59 = -t56;
t60 = -t57;
t61 = -t58;
t63 = a1.*t62;
t65 = t50+t51;
t66 = t52+t53;
t67 = t54+t55;
t64 = abs(t63);
t69 = t47+t59;
t70 = t48+t60;
t71 = t49+t61;
t72 = H.*eta.*t66.*xi;
t73 = W.*t66.*xi.*zeta;
t77 = (H.*eta.*t65.*xi)./4.0;
t78 = (H.*eta.*t67.*xi)./4.0;
t79 = (W.*t65.*xi.*zeta)./4.0;
t80 = (W.*t67.*xi.*zeta)./4.0;
t86 = (H.*t3.*t67.*xi)./4.0;
t87 = (W.*t3.*t67.*xi)./4.0;
t88 = (W.*t3.*t67.*zeta)./4.0;
t93 = (H.*eta.*t3.*t67)./4.0;
t94 = (H.*t11.*t65.*xi)./4.0;
t95 = (W.*t11.*t65.*xi)./4.0;
t96 = (W.*t11.*t65.*zeta)./4.0;
t98 = (H.*eta.*t11.*t65)./4.0;
t103 = (H.*t16.*t66)./2.0;
t105 = (W.*t16.*t66)./2.0;
t68 = t64.^2;
t74 = H.*eta.*t70.*xi;
t75 = -t72;
t76 = W.*t70.*xi.*zeta;
t83 = -t79;
t85 = -t80;
t89 = (H.*eta.*t69.*xi)./4.0;
t90 = (H.*eta.*t71.*xi)./4.0;
t91 = (W.*t69.*xi.*zeta)./4.0;
t92 = (W.*t71.*xi.*zeta)./4.0;
t97 = -t88;
t99 = (H.*t3.*t71.*xi)./4.0;
t100 = (W.*t3.*t71.*xi)./4.0;
t101 = -t96;
t102 = (W.*t3.*t71.*zeta)./4.0;
t104 = (H.*eta.*t3.*t71)./4.0;
t106 = (H.*t11.*t69.*xi)./4.0;
t107 = (W.*t11.*t69.*xi)./4.0;
t108 = (W.*t11.*t69.*zeta)./4.0;
t109 = -t103;
t110 = (H.*eta.*t11.*t69)./4.0;
t111 = -t105;
t112 = (H.*t16.*t70)./2.0;
t113 = (W.*t16.*t70)./2.0;
t81 = t12.*t68.*4.0;
t82 = -t74;
t84 = -t76;
t114 = -t112;
t115 = -t113;
t116 = t86+t94+t109;
t117 = t87+t95+t111;
t118 = t99+t106+t114;
t119 = t100+t107+t115;
t120 = a2.*t8.*t116.*2.0;
t121 = a3.*t10.*t117.*2.0;
t125 = t15+t19+t22+t31+t46+t75+t77+t78+t84+t91+t92+t93+t98+t102+t108;
t126 = t14+t18+t21+t30+t45+t73+t82+t83+t85+t89+t90+t97+t101+t104+t110;
t122 = -t121;
t123 = a2.*t8.*t118.*2.0;
t124 = a3.*t10.*t119.*2.0;
t127 = a1.*t9.*t125.*2.0;
t128 = a1.*t9.*t126.*2.0;
t129 = t120+t124+t127;
t132 = t122+t123+t128;
t130 = abs(t129);
t133 = abs(t132);
t131 = t130.^2;
t134 = t133.^2;
t135 = t81+t131+t134;
t136 = 1.0./sqrt(t135);
a0_fib = [t9.*t63.*t136.*2.0;t132.*t136;t129.*t136];
