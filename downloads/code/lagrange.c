#include
#include
#include
#include
#include
#define MAX 100
main()
{
FILE *fp;
float x[MAX],y[MAX],tmp;
double l[MAX];
float tmp1,tmp2,zhi,xx;
int ii,count,j,k;
//get x and y
fp=fopen(“data.txt”,”r”);
if (!fp)
{
perror(“open file error:”);
exit(1);
}
fscanf(fp,”%d”,&count); //the number of pair key
//printf(“the number is %dn”,count);
for(i=0;i {
fscanf(fp,"%f ",&tmp1);
x[ii]=tmp1;
printf("x[%d] is %ft",i,x[ii]);
fscanf(fp,"%f",&tmp2);
y[ii]=tmp2;
printf("y[%d] is %fn",i,y[ii]);
}
//get l()
tmp=1.0;
for(k=0;k {
for(j=0;j {
if (j==k) continue;
//printf("x[k] is %f and x[j] is %f k is %d and j is %dn ",x[k],x[j],k,j);
tmp=tmp*(x[k] - x[j]);
//printf("tmp is %.6fn",tmp);
}
l[k]= tmp;
tmp=1.0;
}
for(i=0;i printf("l[%d] is %.6fn",i,l[ii]);
printf("n ok,lagrange insert value product ,please input your x value");

scanf("%f",&xx);

printf("n ,now ,the y is ");
tmp1=1.0;
for(k=0;k {
tmp2=1.0;
for(j=0;j {
if (j==k) continue;
tmp2*=(xx-x[j]);
}
zhi=tmp2/l[k];
tmp1+=y[k]*zhi;
}
printf("%f",zhi);
return 0;
}