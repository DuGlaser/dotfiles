import * as cdk from 'aws-cdk-lib';
import { Construct } from 'constructs';

export class TestUbuntuStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const vpc = new cdk.aws_ec2.Vpc(this, "dotfiles-vpc", {
      ipAddresses: cdk.aws_ec2.IpAddresses.cidr("10.1.1.0/24"),
      enableDnsHostnames: true,
      enableDnsSupport: true,
      natGateways: 0,
      maxAzs: 1,
      subnetConfiguration: [
        {
          name: "Public",
          subnetType: cdk.aws_ec2.SubnetType.PUBLIC,
          cidrMask: 27,
          mapPublicIpOnLaunch: true,
        },
      ],
    });

    const ami = new cdk.aws_ec2.LookupMachineImage({
      name: "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-arm64-server-20230919"
    })

    new cdk.aws_ec2.Instance(this, "test-ubuntu", {
      machineImage: ami,
      instanceType: new cdk.aws_ec2.InstanceType("c7g.xlarge"),
      vpc,
      vpcSubnets: vpc.selectSubnets({
        subnetGroupName: "Public",
      }),
      propagateTagsToVolumeOnCreation: true,
      ssmSessionPermissions: true,
    });
  }
}
