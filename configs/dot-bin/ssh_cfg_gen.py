#!/usr/bin/env python3

import ipaddress
import argparse

def gen_host_cfg(subnet):
    prefix = subnet.split('/')[1]
    if 16 < int(prefix) <= 24:
        my_subnets = list(ipaddress.ip_network(subnet).subnets(new_prefix=24))
        my_host_config = []
        block_count = 0
        i = len(my_subnets)
        for each_subnet in my_subnets:
            subnet_list = str(each_subnet[0]).split('.')
            if block_count == 0:
                if i >= 9:
                    if (int(subnet_list[2]) % 10) == 0:
                        if subnet_list[2] == '100' or subnet_list[2] == '200':
                            subnet_list[2] = subnet_list[2][::-1].replace('0', '?', 1)[::-1]
                        else:
                            subnet_list[2] = subnet_list[2].replace('0', '?')
                        subnet_list[3] = subnet_list[3].replace('0', '*')
                        my_host_config.append('.'.join(subnet_list))
                        block_count = 9
                    else:
                        subnet_list[3] = subnet_list[3].replace('0', '*')
                        my_host_config.append('.'.join(subnet_list))
                elif i < 9:
                    subnet_list[3] = subnet_list[3].replace('0', '*')
                    my_host_config.append('.'.join(subnet_list))
            elif block_count > 0:
                block_count -= 1
            i -= 1
        return(my_host_config)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate SSH host config from subnet.')
    parser.add_argument('subnet', type=str)
    args = parser.parse_args()

    host_config_list = gen_host_cfg(args.subnet)
    print('Host %s' % (' '.join(host_config_list)))
