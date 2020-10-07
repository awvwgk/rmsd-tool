! This file is part of mctc-rmsd.
!
! mctc-rmsd is free software: you can redistribute it and/or modify it under
! the terms of the GNU Lesser General Public License as published by
! the Free Software Foundation, either version 3 of the License, or
! (at your option) any later version.
!
! mctc-rmsd is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
! GNU Lesser General Public License for more details.
!
! You should have received a copy of the GNU Lesser General Public License
! along with mctc-rmsd.  If not, see <https://www.gnu.org/licenses/>.

module test_rmsd
   use mctc_env, only : wp
   use mctc_env_testing, only : new_unittest, unittest_type, error_type, check
   use rmsd
   implicit none
   private

   public :: collect_rmsd

   real(wp), parameter :: thr = 100*epsilon(1.0_wp)


contains


!> Collect all exported unit tests
subroutine collect_rmsd(testsuite)

   !> Collection of tests
   type(unittest_type), allocatable, intent(out) :: testsuite(:)

   testsuite = [ &
      & new_unittest("valid1-rmsd", test_rmsd1), &
      & new_unittest("valid2-rmsd", test_rmsd2), &
      & new_unittest("valid3-rmsd", test_rmsd3) &
      & ]

end subroutine collect_rmsd


subroutine test_rmsd1(error)

   !> Error handling
   type(error_type), allocatable, intent(out) :: error

   integer, parameter :: nat = 24
   real(wp), parameter :: xyz1(3, nat) = reshape([&
      & -3.2624567556_wp, -1.0740397867_wp, -0.0000043734_wp, &
      & -2.2754344008_wp, -0.0292896574_wp,  0.0000359020_wp, &
      & -0.9120851382_wp, -0.2075386125_wp, -0.0004880509_wp, &
      & -0.3749333299_wp,  1.0720554184_wp, -0.0001564184_wp, &
      & -1.3570794708_wp,  1.9998111614_wp,  0.0003858762_wp, &
      & -2.4726070186_wp,  1.3013159995_wp,  0.0005402177_wp, &
      & -3.4474896946_wp,  1.7467507266_wp,  0.0010080843_wp, &
      &  0.9669701935_wp,  1.2880523079_wp, -0.0003374012_wp, &
      &  1.8275740716_wp,  0.2107859932_wp, -0.0000027214_wp, &
      &  3.0306801280_wp,  0.3524772071_wp,  0.0002192165_wp, &
      &  1.2570001166_wp, -1.0570195560_wp, -0.0000714961_wp, &
      & -0.0994181855_wp, -1.3854842224_wp, -0.0003307823_wp, &
      & -0.4879332634_wp, -2.5400052828_wp, -0.0002686844_wp, &
      &  2.2118766147_wp, -2.1535108670_wp,  0.0005997875_wp, &
      &  1.6458936552_wp, -3.0819689593_wp,  0.0002644601_wp, &
      &  2.8452151680_wp, -2.0921377814_wp, -0.8838098923_wp, &
      &  2.8439724684_wp, -2.0920881626_wp,  0.8858951171_wp, &
      &  1.4878336345_wp,  2.6373781425_wp, -0.0003075130_wp, &
      &  1.1373305002_wp,  3.1659703185_wp, -0.8863920642_wp, &
      &  1.1383298601_wp,  3.1656042978_wp,  0.8863960393_wp, &
      &  2.5739975007_wp,  2.5744621695_wp, -0.0008973695_wp, &
      & -3.8918239831_wp, -1.0020514766_wp, -0.8884978421_wp, &
      & -3.8928014413_wp, -1.0010907638_wp,  0.8876971655_wp, &
      & -2.7437217829_wp, -2.0316581902_wp,  0.0007283419_wp],&
      & shape(xyz1))
   real(wp), parameter :: xyz2(3, nat) = reshape([&
      & -3.2668063145_wp, -1.0612383311_wp,  0.0019792586_wp, &
      & -2.2766003898_wp, -0.0195172936_wp, -0.0013208218_wp, &
      & -0.9134590858_wp, -0.2019878522_wp,  0.0036747135_wp, &
      & -0.3724701006_wp,  1.0762202467_wp,  0.0017569102_wp, &
      & -1.3526586265_wp,  2.0066755645_wp, -0.0051933750_wp, &
      & -2.4700895686_wp,  1.3111433173_wp, -0.0065911261_wp, &
      & -3.4434528448_wp,  1.7598589152_wp, -0.0115392456_wp, &
      &  0.9701620055_wp,  1.2833365802_wp, -0.0008793828_wp, &
      &  1.8257144377_wp,  0.2028321683_wp, -0.0007168653_wp, &
      &  3.0278876281_wp,  0.3474912012_wp, -0.0051812078_wp, &
      &  1.2515027114_wp, -1.0636950051_wp, -0.0008922263_wp, &
      & -0.1065018202_wp, -1.3842039491_wp,  0.0029991689_wp, &
      & -0.5015980556_wp, -2.5366534217_wp,  0.0044099955_wp, &
      &  2.2018357820_wp, -2.1638123093_wp, -0.0037185988_wp, &
      &  1.6323675079_wp, -3.0900622488_wp,  0.0097444448_wp, &
      &  2.8244315108_wp, -2.1119787186_wp, -0.8964193499_wp, &
      &  2.8450781508_wp, -2.0977859157_wp,  0.8731480371_wp, &
      &  1.5216365707_wp,  2.6211569486_wp,  0.0093869454_wp, &
      &  0.7306184352_wp,  3.3088549484_wp, -0.2771144995_wp, &
      &  1.8886888508_wp,  2.8714188674_wp,  1.0060887389_wp, &
      &  2.3551115434_wp,  2.6687817985_wp, -0.6902763920_wp, &
      & -2.7510404767_wp, -2.0202634640_wp, -0.0176576390_wp, &
      & -3.9109098848_wp, -0.9753935259_wp, -0.8744768432_wp, &
      & -3.8816811438_wp, -0.9984445054_wp,  0.9013764258_wp],&
      & shape(xyz2))
   real(wp) :: rmsd

   call get_rmsd(xyz1, xyz2, rmsd)

   call check(error, rmsd, 0.68055799711708453_wp, thr=thr)
   if (allocated(error)) return

   call get_rmsd(xyz2, xyz1, rmsd)

   call check(error, rmsd, 0.68055799711708453_wp, thr=thr)
   if (allocated(error)) return

   call get_rmsd(xyz1, xyz2+spread([10.0_wp, 0.0_wp, 0.0_wp], 2, nat), rmsd)

   call check(error, rmsd, 0.68055799711708453_wp, thr=thr)
   if (allocated(error)) return

   call get_rmsd(xyz2, xyz1+spread([1.0_wp, 1.0_wp, 1.0_wp], 2, nat), rmsd)

   call check(error, rmsd, 0.68055799711708453_wp, thr=thr)

end subroutine test_rmsd1


subroutine test_rmsd2(error)

   !> Error handling
   type(error_type), allocatable, intent(out) :: error

   integer, parameter :: nat = 24
   real(wp), parameter :: xyz1(3, nat) = reshape([&
      & -3.2624567556_wp, -1.0740397867_wp, -0.0000043734_wp, &
      & -2.2754344008_wp, -0.0292896574_wp,  0.0000359020_wp, &
      & -0.9120851382_wp, -0.2075386125_wp, -0.0004880509_wp, &
      & -0.3749333299_wp,  1.0720554184_wp, -0.0001564184_wp, &
      & -1.3570794708_wp,  1.9998111614_wp,  0.0003858762_wp, &
      & -2.4726070186_wp,  1.3013159995_wp,  0.0005402177_wp, &
      & -3.4474896946_wp,  1.7467507266_wp,  0.0010080843_wp, &
      &  0.9669701935_wp,  1.2880523079_wp, -0.0003374012_wp, &
      &  1.8275740716_wp,  0.2107859932_wp, -0.0000027214_wp, &
      &  3.0306801280_wp,  0.3524772071_wp,  0.0002192165_wp, &
      &  1.2570001166_wp, -1.0570195560_wp, -0.0000714961_wp, &
      & -0.0994181855_wp, -1.3854842224_wp, -0.0003307823_wp, &
      & -0.4879332634_wp, -2.5400052828_wp, -0.0002686844_wp, &
      &  2.2118766147_wp, -2.1535108670_wp,  0.0005997875_wp, &
      &  1.6458936552_wp, -3.0819689593_wp,  0.0002644601_wp, &
      &  2.8452151680_wp, -2.0921377814_wp, -0.8838098923_wp, &
      &  2.8439724684_wp, -2.0920881626_wp,  0.8858951171_wp, &
      &  1.4878336345_wp,  2.6373781425_wp, -0.0003075130_wp, &
      &  1.1373305002_wp,  3.1659703185_wp, -0.8863920642_wp, &
      &  1.1383298601_wp,  3.1656042978_wp,  0.8863960393_wp, &
      &  2.5739975007_wp,  2.5744621695_wp, -0.0008973695_wp, &
      & -3.8918239831_wp, -1.0020514766_wp, -0.8884978421_wp, &
      & -3.8928014413_wp, -1.0010907638_wp,  0.8876971655_wp, &
      & -2.7437217829_wp, -2.0316581902_wp,  0.0007283419_wp],&
      & shape(xyz1))
   real(wp), parameter :: xyz2(3, nat) = reshape([&
      & -0.0004553110_wp, -3.2617762665_wp, -1.0720226051_wp, &
      & -0.0002618619_wp, -2.2753047705_wp, -0.0267931813_wp, &
      & -0.0000194673_wp, -0.9125773797_wp, -0.2060591936_wp, &
      & -0.0000419974_wp, -0.3734253769_wp,  1.0721417806_wp, &
      & -0.0000941625_wp, -1.3545001929_wp,  2.0013179933_wp, &
      & -0.0002785905_wp, -2.4709374084_wp,  1.3043327965_wp, &
      & -0.0006077346_wp, -3.4451984891_wp,  1.7510422697_wp, &
      &  0.0003238447_wp,  0.9691894090_wp,  1.2866487080_wp, &
      & -0.0000817783_wp,  1.8345798771_wp,  0.2137017210_wp, &
      & -0.0004396408_wp,  3.0367430261_wp,  0.3698678394_wp, &
      & -0.0002527998_wp,  1.2614673033_wp, -1.0538979528_wp, &
      &  0.0004906432_wp, -0.0950278305_wp, -1.3803977420_wp, &
      &  0.0012544774_wp, -0.4689895069_wp, -2.5389099492_wp, &
      & -0.0008053695_wp,  2.1703980333_wp, -2.1894003625_wp, &
      & -0.0160041820_wp,  3.1888473374_wp, -1.8115979767_wp, &
      &  0.8915024970_wp,  2.0001903161_wp, -2.7916471867_wp, &
      & -0.8780578272_wp,  1.9782081342_wp, -2.8067842363_wp, &
      &  0.0006452067_wp,  1.4850881897_wp,  2.6382489667_wp, &
      &  0.8863797032_wp,  1.1311990487_wp,  3.1650703632_wp, &
      &  0.0021149919_wp,  2.5713923961_wp,  2.5808144903_wp, &
      & -0.8862767778_wp,  1.1337276718_wp,  3.1647695045_wp, &
      & -0.8919797081_wp, -3.8873339754_wp, -1.0043178781_wp, &
      &  0.8840591009_wp, -3.8961253053_wp, -0.9958709790_wp, &
      &  0.0064100784_wp, -2.7424311383_wp, -2.0293379724_wp],&
      & shape(xyz2))
   real(wp) :: rmsd, gradient(3, nat)

   call get_rmsd(xyz1, xyz2, rmsd, gradient)

   call check(error, rmsd, 0.96133598061782255_wp, thr=thr)
   if (allocated(error)) return
   call check(error, norm2(gradient), 0.20412414523193007_wp, thr=thr)
   if (allocated(error)) return

   call get_rmsd(xyz2, xyz1, rmsd, gradient)

   call check(error, rmsd, 0.96133598061782255_wp, thr=thr)
   if (allocated(error)) return
   call check(error, norm2(gradient), 0.20412414523193007_wp, thr=thr)
   if (allocated(error)) return

end subroutine test_rmsd2


subroutine test_rmsd3(error)

   !> Error handling
   type(error_type), allocatable, intent(out) :: error

   integer, parameter :: nat = 24
   real(wp), parameter :: xyz1(3, nat) = reshape([&
      & -3.2624567556_wp, -1.0740397867_wp, -0.0000043734_wp, &
      & -2.2754344008_wp, -0.0292896574_wp,  0.0000359020_wp, &
      & -0.9120851382_wp, -0.2075386125_wp, -0.0004880509_wp, &
      & -0.3749333299_wp,  1.0720554184_wp, -0.0001564184_wp, &
      & -1.3570794708_wp,  1.9998111614_wp,  0.0003858762_wp, &
      & -2.4726070186_wp,  1.3013159995_wp,  0.0005402177_wp, &
      & -3.4474896946_wp,  1.7467507266_wp,  0.0010080843_wp, &
      &  0.9669701935_wp,  1.2880523079_wp, -0.0003374012_wp, &
      &  1.8275740716_wp,  0.2107859932_wp, -0.0000027214_wp, &
      &  3.0306801280_wp,  0.3524772071_wp,  0.0002192165_wp, &
      &  1.2570001166_wp, -1.0570195560_wp, -0.0000714961_wp, &
      & -0.0994181855_wp, -1.3854842224_wp, -0.0003307823_wp, &
      & -0.4879332634_wp, -2.5400052828_wp, -0.0002686844_wp, &
      &  2.2118766147_wp, -2.1535108670_wp,  0.0005997875_wp, &
      &  1.6458936552_wp, -3.0819689593_wp,  0.0002644601_wp, &
      &  2.8452151680_wp, -2.0921377814_wp, -0.8838098923_wp, &
      &  2.8439724684_wp, -2.0920881626_wp,  0.8858951171_wp, &
      &  1.4878336345_wp,  2.6373781425_wp, -0.0003075130_wp, &
      &  1.1373305002_wp,  3.1659703185_wp, -0.8863920642_wp, &
      &  1.1383298601_wp,  3.1656042978_wp,  0.8863960393_wp, &
      &  2.5739975007_wp,  2.5744621695_wp, -0.0008973695_wp, &
      & -3.8918239831_wp, -1.0020514766_wp, -0.8884978421_wp, &
      & -3.8928014413_wp, -1.0010907638_wp,  0.8876971655_wp, &
      & -2.7437217829_wp, -2.0316581902_wp,  0.0007283419_wp],&
      & shape(xyz1))
   real(wp), parameter :: xyz2(3, nat) = reshape([&
      & -0.0004553110_wp, -3.2617762665_wp, -1.0720226051_wp, &
      & -0.0002618619_wp, -2.2753047705_wp, -0.0267931813_wp, &
      & -0.0000194673_wp, -0.9125773797_wp, -0.2060591936_wp, &
      & -0.0000419974_wp, -0.3734253769_wp,  1.0721417806_wp, &
      & -0.0000941625_wp, -1.3545001929_wp,  2.0013179933_wp, &
      & -0.0002785905_wp, -2.4709374084_wp,  1.3043327965_wp, &
      & -0.0006077346_wp, -3.4451984891_wp,  1.7510422697_wp, &
      &  0.0003238447_wp,  0.9691894090_wp,  1.2866487080_wp, &
      & -0.0000817783_wp,  1.8345798771_wp,  0.2137017210_wp, &
      & -0.0004396408_wp,  3.0367430261_wp,  0.3698678394_wp, &
      & -0.0002527998_wp,  1.2614673033_wp, -1.0538979528_wp, &
      &  0.0004906432_wp, -0.0950278305_wp, -1.3803977420_wp, &
      &  0.0012544774_wp, -0.4689895069_wp, -2.5389099492_wp, &
      & -0.0008053695_wp,  2.1703980333_wp, -2.1894003625_wp, &
      & -0.0160041820_wp,  3.1888473374_wp, -1.8115979767_wp, &
      &  0.8915024970_wp,  2.0001903161_wp, -2.7916471867_wp, &
      & -0.8780578272_wp,  1.9782081342_wp, -2.8067842363_wp, &
      &  0.0006452067_wp,  1.4850881897_wp,  2.6382489667_wp, &
      &  0.8863797032_wp,  1.1311990487_wp,  3.1650703632_wp, &
      &  0.0021149919_wp,  2.5713923961_wp,  2.5808144903_wp, &
      & -0.8862767778_wp,  1.1337276718_wp,  3.1647695045_wp, &
      & -0.8919797081_wp, -3.8873339754_wp, -1.0043178781_wp, &
      &  0.8840591009_wp, -3.8961253053_wp, -0.9958709790_wp, &
      &  0.0064100784_wp, -2.7424311383_wp, -2.0293379724_wp],&
      & shape(xyz2))
   character, parameter :: sym(nat) = [&
      & "C", "N", "C", "C", "N", "C", "H", "N", "C", "O", "N", "C", &
      & "O", "C", "H", "H", "H", "C", "H", "H", "H", "H", "H", "H"]
   real(wp) :: rmsd, gradient(3, nat)

   call get_rmsd(xyz1, xyz2, rmsd, gradient, mask=sym.ne."H")

   call check(error, rmsd, 1.651080188719468e-2_wp, thr=thr)
   if (allocated(error)) return
   call check(error, norm2(gradient), 0.267219089342489_wp, thr=thr)
   if (allocated(error)) return

end subroutine test_rmsd3


end module test_rmsd