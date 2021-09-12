//�p�[�g�P�F�ϐ��̒�`///////////////////////////////////

//�����ϐ�
var y pi epi gpi r y_obs pi_obs epi_obs gpi_obs r_obs;

//�O���ϐ�
varexo ugpi uy upi uepi ugpi ur;

//�p�����[�^
parameters theta alpha phipi phiy zeta gamma;

//�p�[�g�Q�F�J���u���[�g����p�����[�^//////////////////

theta =   1.50         ; %����̑�֒e�͐�
alpha =   0.10         ; %NKPC��GDPgap��
phipi =   1.70         ; %Taylor rule�̃C���t������
phiy  =   0.08         ; %Taylor rule��GDPgap��

//zeta  =   0.50         ; %���N�H�i�C���t�����ɔ�������ƌv�̊���
//gamma =   0.70         ; %���N�H�i�C���t�����̎�����(AR1)

//�p�[�g�R�F���f��///////////////////////////////////////

model(linear);

//���^���f��

y   = y(+1) - theta*(r-epi(+1))      ;
epi = (1-zeta)*pi + zeta*gpi(-1) ;
gpi = gamma*gpi(-1) + ugpi           ;
pi  = epi(+1)+ alpha*y               ;
r   = phipi*pi + phiy*y              ;

//�ϑ�������

y_obs=y+uy; %GDP�̊ϑ�������
pi_obs=pi+upi; %�C���t�����̊ϑ�������
epi_obs=epi+uepi; 
gpi_obs=gpi+ugpi; 
r_obs=r+ur; 

end;

//�p�[�g�S�F���v����p�����[�^�̎��O���z(�]��2011�A�A��2012�A���c2009�Ȃ�)///////////

estimated_params;
zeta, normal_pdf, 0.5, 0.2; 
gamma, beta_pdf, 0.5, 0.2; 
stderr uy, inv_gamma_pdf, 0.1, inf; %�ȉ��A�e�����ϐ��̊ϑ��덷
stderr upi, inv_gamma_pdf, 0.1, inf;
stderr ugpi, inv_gamma_pdf, 0.1, inf;
stderr ur, inv_gamma_pdf, 0.1, inf;
stderr uepi, inv_gamma_pdf, 0.1, inf;
end;

//�p�[�g�T�F���v///////////////////////////////////////////////////////////

//�ϑ�����ϐ��̎w��
varobs y_obs pi_obs epi_obs gpi_obs r_obs;

//���v�R�}���h(�J���}���X���[�W���O�Ȃ�)//////////////////////////////
estimation(datafile=df, mode_check, mh_replic=100000, mh_nblocks=2, 
mh_drop=0.5, mh_jscale=0.89, bayesian_irf);
////////////////////////////////////////////////////////////////////////


//�����I���ҋύt���̓��o
stoch_simul;

//�q�X�g���J���������s���R�}���h
shock_decomposition(parameter_set=posterior_mean) pi_obs;