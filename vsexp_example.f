!*******************************************************************************
!  Copyright(C) 2001-2012 Intel Corporation. All Rights Reserved.
!
!  The source code, information  and  material ("Material") contained herein is
!  owned  by Intel Corporation or its suppliers or licensors, and title to such
!  Material remains  with Intel Corporation  or its suppliers or licensors. The
!  Material  contains proprietary information  of  Intel or  its  suppliers and
!  licensors. The  Material is protected by worldwide copyright laws and treaty
!  provisions. No  part  of  the  Material  may  be  used,  copied, reproduced,
!  modified, published, uploaded, posted, transmitted, distributed or disclosed
!  in any way  without Intel's  prior  express written  permission. No  license
!  under  any patent, copyright  or  other intellectual property rights  in the
!  Material  is  granted  to  or  conferred  upon  you,  either  expressly,  by
!  implication, inducement,  estoppel or  otherwise.  Any  license  under  such
!  intellectual  property  rights must  be express  and  approved  by  Intel in
!  writing.
!
!  *Third Party trademarks are the property of their respective owners.
!
!  Unless otherwise  agreed  by Intel  in writing, you may not remove  or alter
!  this  notice or  any other notice embedded  in Materials by Intel or Intel's
!  suppliers or licensors in any way.
!
!*******************************************************************************
!  Content:
!    vsExp  Example Program Text
!*******************************************************************************

      include "_rms.fi"

      program MKL_VML_TEST

      include "mkl_vml.f90"
      real(kind=4) :: srelerr
      real(kind=8) :: drelerr
      real(kind=4) :: crelerr
      real(kind=8) :: zrelerr

      real(kind=4) fA(10)
      real(kind=4) fB(10)
      real(kind=4) fBha0(10)
      real(kind=4) fBha1(10)
      real(kind=4) fBha2(10)
      real(kind=4) fBla1(10)
      real(kind=4) fBla2(10)
      real(kind=4) fBep1(10)
      real(kind=4) fBep2(10)

      real(kind=4) CurRMS,MaxRMS

      integer(kind=8) mode
      integer tmode
      integer i, vec_len

      vec_len=10
      MaxRMS=0.0

      fA( 1)=-17.0000
      fA( 2)=-13.1111
      fA( 3)=-9.2222
      fA( 4)=-5.3333
      fA( 5)=-1.4444
      fA( 6)=2.4444
      fA( 7)=6.3333
      fA( 8)=10.2222
      fA( 9)=14.1111
      fA(10)=18.0000
      fB( 1)=4.1399377187851668e-008
      fB( 2)=2.0226536979919889e-006
      fB( 3)=9.8821003114055964e-005
      fB( 4)=4.8281103793302660e-003
      fB( 5)=2.3588757775759897e-001
      fB( 6)=1.1523634174991830e+001
      fB( 7)=5.6301153347619049e+002
      fB( 8)=2.7507126448834904e+004
      fB( 9)=1.3439185517311485e+006
      fB(10)=6.5659969137330510e+007

      call VSEXP(vec_len,fA,fBha0)

      mode=VML_EP
      call VMSEXP(vec_len,fA,fBep1,mode)

      tmode=VML_EP
      tmode=VMLSETMODE(tmode)
      call VSEXP(vec_len,fA,fBep2)

      mode=VML_LA
      call VMSEXP(vec_len,fA,fBla1,mode)

      tmode=VML_LA
      tmode=VMLSETMODE(tmode)
      call VSEXP(vec_len,fA,fBla2)

      mode=VML_HA
      call VMSEXP(vec_len,fA,fBha1,mode)

      tmode=VML_HA
      tmode=VMLSETMODE(tmode)
      call VSEXP(vec_len,fA,fBha2)

      do i=1,10
          if(fBha0(i) .ne. fBha1(i)) then
              print *,"Error! Difference between VSEXP and"
              print *," VMSEXP in VML_HA mode detected"
              stop 1
          endif
          if(fBha1(i) .ne. fBha2(i)) then
              print *,"Error! Difference between VSEXP and"
              print *," VMSEXP in VML_HA mode detected"
              stop 1
          endif
          if(fBla1(i) .ne. fBla2(i)) then
              print *,"Error! Difference between VSEXP and"
              print *," VMSEXP in VML_LA mode detected"
              stop 1
          endif
          if(fBep1(i) .ne. fBep2(i)) then
              print *,"Error! Difference between VSEXP and"
              print *," VMSEXP in VML_EP mode detected"
              stop 1
          endif
      end do

      print *,"vsExp test/example program"
      print *,""
      print *,"           Argument                     vsExp"
      print *,"======================================================", &
     &        "========================"
      do i=1,10
            print 10,fA(i),fBha0(i)
            CurRMS=srelerr(fB(i),fBha0(i))
            if(CurRMS>MaxRMS) MaxRMS=CurRMS
      end do

      print *,""
      if(MaxRMS>=1e-5) then
            print 11,"Error! Relative accuracy is ",MaxRMS
            stop 1
      else
            print 11,"Relative accuracy is ",MaxRMS
      endif

10    format(E25.14,E25.14)
11    format(A,F25.16)

      end
