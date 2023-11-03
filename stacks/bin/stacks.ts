#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from 'aws-cdk-lib';
import { TestUbuntuStack } from '../lib/test-ubuntu-stack';


const app = new cdk.App();

const ENV = {
  region: 'ap-northeast-1',
  account: app.node.tryGetContext("account")
}

new TestUbuntuStack(app, 'TestUbuntuStack', {
  env: ENV
});
