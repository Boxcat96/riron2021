//�p�[�g�P�F�ϐ��̒�`///////////////////////////////////

//�����ϐ�
var y pi epi u y_obs pi_obs epi_obs;

//�O���ϐ�
varexo ueta uepi uu uy;

//�p�����[�^
parameters beta gamma kappa lambda mu rhou phione phitwo phithree phifour;

//�p�[�g�Q�F�J���u���[�g����p�����[�^�i�Ȃ��j//////////////////

//�p�[�g�R�F���f��///////////////////////////////////////

model(linear);

//���^���f��

y = phione*y(-1)+phitwo*y(-2)+phithree*pi(-1)+phifour*pi(-2)+ueta;
pi-gamma*pi(-1) = beta*(epi(+1)-gamma*pi)+kappa*y;
epi = mu*pi+lambda*epi(-1);

//�ϑ�������

y_obs= y+uy; %GDP�̊ϑ�������
pi_obs= epi+u; %�C���t�����̊ϑ�������
u = rhou*u(-1)+uu;
epi_obs= epi+uepi;

end;

//�p�[�g�S�F���v����p�����[�^�̎��O���z(Pfajfar2018)///////////

estimated_params;
beta, normal_pdf, 0.5, 0.5;
gamma, normal_pdf, 0.5, 0.15; 
kappa, normal_pdf, 0.1, 0.1; 
lambda, normal_pdf, 0.75,0.15;
mu, normal_pdf, 0.25, 0.15;
rhou, normal_pdf, 0.5, 0.5;
phione, normal_pdf, 1.3, 0.5;
phitwo, normal_pdf, -0.5, 0.5;
phithree, normal_pdf, 0.1, 1.0;
phifour, normal_pdf, 0.1, 1.0;

%�ȉ��A�e�����ϐ��̊ϑ��덷
stderr ueta, inv_gamma_pdf, 0.1, inf; 
stderr uy, inv_gamma_pdf, 0.1, inf; 
stderr uu, inv_gamma_pdf, 0.1, inf;
stderr uepi, inv_gamma_pdf, 0.1, inf;
end;

//�p�[�g�T�F���v///////////////////////////////////////////////////////////

//�ϑ�����ϐ��̎w��
varobs y_obs pi_obs epi_obs;

//���v�R�}���h(�J���}���X���[�W���O�Ȃ�)//////////////////////////////
estimation(datafile=JPdata, mode_check, mh_replic=100000, mh_nblocks=2, 
mh_drop=0.5, mh_jscale=0.50, bayesian_irf);
////////////////////////////////////////////////////////////////////////


//�����I���ҋύt���̓��o
stoch_simul;